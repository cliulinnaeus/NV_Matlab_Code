/*
 * This file was automatically generated for MATLAB by H2MEX on
 * Sun Mar 19 02:29:24 2000
 * from gpibx.h.
 * 
 * H2MEX v 1.0, by Alaa Makdissi (c) 1999
 * Alaa.Makdissi@obspm.fr
 * http://opdaf1.obspm.fr/~makdissi
 *
 * The original code is due to the matwrap (v.52) script by Gary R. Holt
 * <holt@monet.klab.caltech.edu>
 */ 

//#define MEM_ALLOC(type, n, size) ((type)mxCalloc(n, size))
#include "gpib2.h"

#ifdef __cplusplus
extern "C" {
#endif
#include "matrix.h"
#include "mex.h"
#ifdef __cplusplus
}
#endif
#ifndef __GNUC__
#include <malloc.h>
#endif
//#include <complex.h>

static void *__cvt_type(void *ptr, unsigned ptr_type, unsigned goal_type);

static int scalar_dimensions[] = {1,1}; // A value to pass to give the 
				// dimensions of a scalar.

//
// Return the maximum of the arguments:
//
template <class FLOAT>
inline FLOAT
max(FLOAT arg1, FLOAT arg2)
{
  return arg1 >= arg2 ? arg1 : arg2;
}

/*
 * Return the number of dimensions of an array.
 * This is not well-defined in matlab; we just return the highest dimension
 * which is not 1.
 */
static int
_n_dims(const mxArray *mat)
{
  if (mxIsChar(mat))		/* Currently we treat all strings as */
    return 0;			/* atomic objects. */
  int n_dim = mxGetNumberOfDimensions(mat); /* Get what matlab thinks. */
  if (n_dim == 2 && mxGetN(mat) == 1) /* 2D array with # of columns = 1? */
  {
    n_dim = 1;			/* It's really a 1D array. */
    if (mxGetM(mat) == 1)	/* Also only one row? */
      n_dim = 0;		/* It's really a scalar. */
  }

  return n_dim;
}

/*
 * Function to get the total number of elements in an array.
 * Arguments:
 * 1) The matlab object.
 *
 * If the object is a scalar, the array length is 1.
 */
static int
_arraylen(const mxArray *mat) {
  int len = 1;
  const int *dims = mxGetDimensions(mat); // Get the number of dimensions.
  int idx;
  for (idx = 0; idx < mxGetNumberOfDimensions(mat); ++idx)
    len *= dims[idx];		// Multiply all the dimensions.

  return len;
}

//
// Get the n'th dimension of a Matlab object.
// Arguments:
// 1) The matlab matrix.
// 2) Which dimension.  0 for the most quickly varying one, etc.
//
static inline int
_dim(const mxArray *mat, int idxno) {
  if (idxno >= mxGetNumberOfDimensions(mat))	// Illegal # of dims?
    return 1;
  else
    return mxGetDimensions(mat)[idxno];	// Return the dimension.
}

//
// Local functions dealing with pointers:
//
// Pointers are stored as complex numbers.  The real part is the pointer value,
// and the complex part is the type code.  Since the real part will be a double
// precision number, the pointer is guaranteed to fit, even on 64-bit machines.
//
// Fill an array with pointers.  Arguments:
// 1) A pointer to the array to fill.  The array is already the correct size.
// 2) The matlab object.
// 3) The pointer type code.
//
// Returns false if some of the pointers have the wrong type.
//
static int
_get_pointer(void **arr, const mxArray *mat, unsigned typecode)
{
  int idx;
  int n_elements;
  double *pr, *pi;

  if (!mxIsComplex(mat))	// Make sure it's the right type.
    return 0;

  n_elements = _arraylen(mat);	// Get the number of elements to convert.
  pr = mxGetPr(mat);		// Get a pointer to the real part.
  pi = mxGetPi(mat);		// Get a pointer to the complex part.
  for (idx = 0; idx < n_elements; ++idx)
  {				// Look at each element:
    unsigned this_typecode = (unsigned)*pi++; // Get the type code.
    if (this_typecode == typecode) // Correct type?
      *arr++ = *(void **)pr;	// Do the conversion.
    else
    {
      *arr = __cvt_type(*(void **)pr, this_typecode, typecode);
				// Check inheritance.
      if (*arr++ == 0) return 0; // Wrong type.
    }

    ++pr;			// Point to the next element.
  }

  return 1;			// No error.
}

//
// Load a matrix with a pointer or an array of pointers.  This assumes
// that the matrix has already been allocated to the correct size
// (that's how we know how many elements to convert).
//
static void
_put_pointer(mxArray *mat, void **ptr_array, double type_code)
{
  int idx;
  int n_elements;
  double *pr, *pi;
  
  n_elements = _arraylen(mat);	// Get the number of elements to convert.
  pr = mxGetPr(mat);		// Get a pointer to the real part.
  pi = mxGetPi(mat);		// Get a pointer to the complex part.

  for (idx = 0; idx < n_elements; ++idx)
  {
    *pi++ = type_code;		// Remember the type code.
    *pr = 0;			// Wipe out any extra bits the address
				// doesn't cover, in case we're on a
				// 32 bit machine.
    *(void **)pr = *ptr_array++; // Remember the address.
    ++pr;			// Advance the pointer.
  }
}

//
// Load up an array (which may consist only of a single element) with
// the values from a matlab object.  Arguments:
// 1) The matlab object.
// 2) Where to put the values.  The array should be allocated sufficiently
//    large so that all of the values in the matlab object can be converted.
//
// These functions return 0 on error, or 1 if the operation succeded.
//
template <class FLOAT>
static int
_get_numeric(const mxArray *mat, FLOAT *arr) // float or double.
{
  int idx;
  int n_elements = _arraylen(mat); // Get the length.

  if (mxIsDouble(mat))		// Ordinary double precision matrix?
  {
    double *pr = mxGetPr(mat);	// Point to vector of double precision values.

    for (idx = 0; idx < n_elements; ++idx) // Loop through all elements.
      *arr++ = (FLOAT)*pr++;	// Convert and copy this element.
  }
  else if (mxIsInt32(mat) || mxIsUint32(mat)) // 32 bit integer?
  {
    INT32_T *pr = (INT32_T *)mxGetData(mat); // Point to the data.
    for (idx = 0; idx < n_elements; ++idx) // Loop through all elements.
      *arr++ = (FLOAT)*pr++;	// Convert and copy this element.
  }
  else if (mxIsInt16(mat) || mxIsUint16(mat)) // 16 bit integer?
  {
    INT16_T *pr = (INT16_T *)mxGetData(mat); // Point to the data.
    for (idx = 0; idx < n_elements; ++idx) // Loop through all elements.
      *arr++ = (FLOAT)*pr++;	// Convert and copy this element.
  }
  else if (mxIsInt8(mat) || mxIsUint8(mat)) // 8 bit integer?
  {
    INT8_T *pr = (INT8_T *)mxGetData(mat); // Point to the data.
    for (idx = 0; idx < n_elements; ++idx) // Loop through all elements.
      *arr++ = (FLOAT)*pr++;	// Convert and copy this element.
  }
  else				// Don't know what this is.
    return 0;			// Type conversion error.

  return 1;			// No error.
}

//
// A version of the above function for complex numbers:
//

/*
 * Check to see if the vectorizing dimensions on an input argument are
 * ok.  Arguments:
 * 1) The input argument.
 * 2) The number of vectorizing dimensions we have so far.  This is updated
 *    if we add more vectorizing dimensions.
 * 3) An array containing the existing vectorizing dimensions.
 * 4) The number of explicitly declared dimensions, i.e., 0 if this was
 *    declared as a scalar, 1 if a vector.  We vectorize only the dimensions
 *    higher than the explicitly declared ones.
 * 5) A value which is set to 0 if this argument is not vectorized.  This
 *    value is left unaltered if the argument is vectorized.
 *
 * Returns 0 if there was a problem, 1 if the dimensions were ok.
 */
int
_check_input_vectorize(const mxArray *arg,
                       int *n_vec_dim,
		       int _d[4],
		       int explicit_dims,
		       int *zero_if_not_vec)
{
  int v_idx;

  int n_dims = _n_dims(arg);

  if (n_dims > explicit_dims)	/* Any additional dimensions? */
  {
    if (*n_vec_dim == 0)	/* No vectorizing dimensions seen yet? */
    {				/* This defines the vectorizing dimensions. */
      *n_vec_dim = n_dims - explicit_dims; /* Remember the # of dims. */
      for (v_idx = 0; v_idx < 4-explicit_dims; ++v_idx)
        _d[v_idx] = _dim(arg, v_idx+explicit_dims); /* Remember this dim. */
    } 
    else			/* Already had some vectorizing dimensions. */
    {				/* These must match exactly. */
      for (v_idx = 0; v_idx < 4-explicit_dims; ++v_idx)
        if (_d[v_idx] != _dim(arg, v_idx+explicit_dims)) /* Wrong size? */
          return 0;		/* Error! */
    }
  }  
/*  else if (n_dims < explicit_dims) */ /* Too few dimensions? */
/*    return 0; */ /* We don't do this check because there's no way to
		    * distinguish between a vector and a 3x1 matrix. */
  else
    *zero_if_not_vec = 0;	/* Flag this as not requiring vectorization. */

  return 1;
}

/*
 * Same thing except for modify variables.  Arguments:
 * 1) The input argument.
 * 2) The number of vectorizing dimensions we have so far.
 * 3) An array containing the existing vectorizing dimensions.
 * 4) The number of explicitly declared dimensions, i.e., 0 if this was
 *    declared as a scalar, 1 if a vector.  We vectorize only the dimensions
 *    higher than the explicitly declared ones.
 * 5) A flag indicating whether this is the first modify variable.  This
 *    flag is passed by reference and updated by this subroutine.
 *
 * The vectorizing dimensions of modify arguments must exactly match those
 * specified for input variables.  The difference between this subroutine
 * and _check_input_vectorize is that only the first modify variable may
 * specify additional vectorizing dimensions.
 *
 * Returns 0 if there was a problem, 1 if the dimensions were ok.
 */
int
_check_modify_vectorize(const mxArray *arg,
		        int *n_vec_dim,
		        int _d[4],
		        int explicit_dims,
			int *first_modify_flag)
{
  int v_idx;

  int n_dims = _n_dims(arg);

  if (n_dims > explicit_dims)	/* Any additional dimensions? */
  {
    if (*n_vec_dim == 0 && *first_modify_flag)	/* No vectorizing dimensions seen yet? */
    {				/* This defines the vectorizing dimensions. */
      *n_vec_dim = n_dims - explicit_dims; /* Remember the # of dims. */
      for (v_idx = 0; v_idx < 4-explicit_dims; ++v_idx)
        _d[v_idx] = _dim(arg, v_idx+explicit_dims); /* Remember this dim. */
    } 
    else			/* Already had some vectorizing dimensions. */
    {				/* These must match exactly. */
      for (v_idx = 0; v_idx < 4-explicit_dims; ++v_idx)
        if (_d[v_idx] != _dim(arg, v_idx+explicit_dims)) /* Wrong size? */
          return 0;		/* Error! */
    }
  }  
/*  else if (n_dims < explicit_dims) */ /* Too few dimensions? */
/*    return 0; */ /* We don't do this check because there's no way to
		    * distinguish between a vector and a 3x1 matrix. */

  *first_modify_flag = 0;	/* Next modify variable will not be first. */
  return 1;
}


/*
 * Convert between classes, handling inheritance relationships.
 * Arguments:
 * 1) The pointer.
 * 2) The type code for its class.
 * 3) The type code for the class you want.
 *
 * Returns 0 if the conversion is illegal, or else returns the
 * desired pointer.
 * We assume that you have already verified that the type code does
 * not match, so the only valid possibility is an inheritance
 * relationship.
 */
static void *
__cvt_type(void *, unsigned, unsigned)
{
  return 0;
}

void _wrap_AllSpoll(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function AllSpoll");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_boardID;
  int *_arg_addrlist;
  int *_arg_results;
  int _vecstride_boardID = 1;
  int _vecstride_addrlist = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_boardID))
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_boardID = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_boardID = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_boardID))
      mexErrMsgTxt("Expecting numeric matrix for argument boardID");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_addrlist))
    mexErrMsgTxt("Error in dimension of argument addrlist");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_addrlist = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_addrlist = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_addrlist))
      mexErrMsgTxt("Expecting numeric matrix for argument addrlist");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_results = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    AllSpoll(_arg_boardID[_vecstride_boardID*_vidx], &_arg_addrlist[_vecstride_addrlist*_vidx], &_arg_results[_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_results++;
  }
}

void _wrap_DevClear(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function DevClear");
  int _arg_boardID;
  int _arg_addr;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument addr");
  if (!_get_numeric(prhs[2], &_arg_addr))
    mexErrMsgTxt("Expecting numeric scalar for argument addr");

    DevClear(_arg_boardID, _arg_addr);
}

void _wrap_DevClearList(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function DevClearList");
  int _arg_boardID;
  int _arg_addrlist;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument addrlist");
  if (!_get_numeric(prhs[2], &_arg_addrlist))
    mexErrMsgTxt("Expecting numeric scalar for argument addrlist");

    DevClearList(_arg_boardID, &_arg_addrlist);
}

void _wrap_EnableLocal(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function EnableLocal");
  int _arg_boardID;
  int _arg_addrlist;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument addrlist");
  if (!_get_numeric(prhs[2], &_arg_addrlist))
    mexErrMsgTxt("Expecting numeric scalar for argument addrlist");

    EnableLocal(_arg_boardID, &_arg_addrlist);
}

void _wrap_EnableRemote(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function EnableRemote");
  int _arg_boardID;
  int _arg_addrlist;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument addrlist");
  if (!_get_numeric(prhs[2], &_arg_addrlist))
    mexErrMsgTxt("Expecting numeric scalar for argument addrlist");

    EnableRemote(_arg_boardID, &_arg_addrlist);
}

void _wrap_FindLstn(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 3+1)
    mexErrMsgTxt("Wrong number of arguments to function FindLstn");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_boardID;
  int *_arg_addrlist;
  int *_arg_results;
  int _arg_limit;
  if (!_get_numeric(prhs[3], &_arg_limit))
    mexErrMsgTxt("Expecting numeric scalar for argument limit");
  int _vecstride_boardID = 1;
  int _vecstride_addrlist = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_boardID))
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_boardID = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_boardID = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_boardID))
      mexErrMsgTxt("Expecting numeric matrix for argument boardID");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_addrlist))
    mexErrMsgTxt("Error in dimension of argument addrlist");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_addrlist = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_addrlist = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_addrlist))
      mexErrMsgTxt("Expecting numeric matrix for argument addrlist");
  }

  if (_n_dims(prhs[3]) > 0)
    mexErrMsgTxt("Error in dimension of argument limit");

  {
    int _ds[] = { _arg_limit, _d[0] , _d[1] , _d[2]  };
    plhs[0] = mxCreateNumericArray(max((1 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_results = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    FindLstn(_arg_boardID[_vecstride_boardID*_vidx], &_arg_addrlist[_vecstride_addrlist*_vidx], &_arg_results[_arg_limit*_vidx], _arg_limit);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_results++;
  }
}

void _wrap_FindRQS(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function FindRQS");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_boardID;
  int *_arg_addrlist;
  int *_arg_dev_stat;
  int _vecstride_boardID = 1;
  int _vecstride_addrlist = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_boardID))
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_boardID = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_boardID = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_boardID))
      mexErrMsgTxt("Expecting numeric matrix for argument boardID");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_addrlist))
    mexErrMsgTxt("Error in dimension of argument addrlist");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_addrlist = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_addrlist = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_addrlist))
      mexErrMsgTxt("Expecting numeric matrix for argument addrlist");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_dev_stat = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    FindRQS(_arg_boardID[_vecstride_boardID*_vidx], &_arg_addrlist[_vecstride_addrlist*_vidx], &_arg_dev_stat[_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_dev_stat++;
  }
}

void _wrap_PPoll(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 1+1)
    mexErrMsgTxt("Wrong number of arguments to function PPoll");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_boardID;
  int *_arg_result;
  int _vecstride_boardID = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_boardID))
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_boardID = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_boardID = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_boardID))
      mexErrMsgTxt("Expecting numeric matrix for argument boardID");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_result = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    PPoll(_arg_boardID[_vecstride_boardID*_vidx], &_arg_result[_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_result++;
  }
}

void _wrap_PPollConfig(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 4+1)
    mexErrMsgTxt("Wrong number of arguments to function PPollConfig");
  int _arg_boardID;
  int _arg_addr;
  int _arg_dataLine;
  int _arg_lineSense;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument addr");
  if (!_get_numeric(prhs[2], &_arg_addr))
    mexErrMsgTxt("Expecting numeric scalar for argument addr");

  if (_n_dims(prhs[3]) > 0)
    mexErrMsgTxt("Error in dimension of argument dataLine");
  if (!_get_numeric(prhs[3], &_arg_dataLine))
    mexErrMsgTxt("Expecting numeric scalar for argument dataLine");

  if (_n_dims(prhs[4]) > 0)
    mexErrMsgTxt("Error in dimension of argument lineSense");
  if (!_get_numeric(prhs[4], &_arg_lineSense))
    mexErrMsgTxt("Expecting numeric scalar for argument lineSense");

    PPollConfig(_arg_boardID, _arg_addr, _arg_dataLine, _arg_lineSense);
}

void _wrap_PPollUnconfig(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function PPollUnconfig");
  int _arg_boardID;
  int _arg_addrlist;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument addrlist");
  if (!_get_numeric(prhs[2], &_arg_addrlist))
    mexErrMsgTxt("Expecting numeric scalar for argument addrlist");

    PPollUnconfig(_arg_boardID, &_arg_addrlist);
}

void _wrap_PassControl(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function PassControl");
  int _arg_boardID;
  int _arg_addr;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument addr");
  if (!_get_numeric(prhs[2], &_arg_addr))
    mexErrMsgTxt("Expecting numeric scalar for argument addr");

    PassControl(_arg_boardID, _arg_addr);
}

void _wrap_RcvRespMsg(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 3+1)
    mexErrMsgTxt("Wrong number of arguments to function RcvRespMsg");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_boardID;
  void * *_arg_buffer;
  int _arg_cnt;
  int *_arg_Termination;
  if (!_get_numeric(prhs[2], &_arg_cnt))
    mexErrMsgTxt("Expecting numeric scalar for argument cnt");
  int _vecstride_boardID = 1;
  int _vecstride_Termination = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_boardID))
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_boardID = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_boardID = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_boardID))
      mexErrMsgTxt("Expecting numeric matrix for argument boardID");
  }

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument cnt");

  if (!_check_input_vectorize(prhs[3], &_vec_n, _d, 0, &_vecstride_Termination))
    mexErrMsgTxt("Error in dimension of argument Termination");
  if (mxIsInt32(prhs[3]) || mxIsUint32(prhs[3]))
    _arg_Termination = (int *)mxGetData(prhs[3]);
   else
  {
    _arg_Termination = (int *)alloca(_arraylen(prhs[3]) * sizeof (int));
    if (!_get_numeric(prhs[3], _arg_Termination))
      mexErrMsgTxt("Expecting numeric matrix for argument Termination");
  }

  {
    int _ds[] = { _arg_cnt, _d[0] , _d[1] , _d[2]  };
    plhs[0] = mxCreateNumericArray(max((1 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxCOMPLEX);
    _arg_buffer = (void * *)alloca(_arraylen(plhs[0]) * sizeof (void *));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    RcvRespMsg(_arg_boardID[_vecstride_boardID*_vidx], &_arg_buffer[_arg_cnt*_vidx], _arg_cnt, _arg_Termination[_vecstride_Termination*_vidx]);
  }
  _put_pointer(plhs[0], (void **)_arg_buffer, 353986040); /* void * */
}

void _wrap_ReadStatusByte(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ReadStatusByte");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_boardID;
  int *_arg_addr;
  int *_arg_result;
  int _vecstride_boardID = 1;
  int _vecstride_addr = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_boardID))
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_boardID = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_boardID = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_boardID))
      mexErrMsgTxt("Expecting numeric matrix for argument boardID");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_addr))
    mexErrMsgTxt("Error in dimension of argument addr");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_addr = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_addr = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_addr))
      mexErrMsgTxt("Expecting numeric matrix for argument addr");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_result = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    ReadStatusByte(_arg_boardID[_vecstride_boardID*_vidx], _arg_addr[_vecstride_addr*_vidx], &_arg_result[_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_result++;
  }
}

void _wrap_Receive(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 4+1)
    mexErrMsgTxt("Wrong number of arguments to function Receive");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_boardID;
  int *_arg_addr;
  void * *_arg_buffer;
  int _arg_cnt;
  int *_arg_Termination;
  if (!_get_numeric(prhs[3], &_arg_cnt))
    mexErrMsgTxt("Expecting numeric scalar for argument cnt");
  int _vecstride_boardID = 1;
  int _vecstride_addr = 1;
  int _vecstride_Termination = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_boardID))
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_boardID = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_boardID = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_boardID))
      mexErrMsgTxt("Expecting numeric matrix for argument boardID");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_addr))
    mexErrMsgTxt("Error in dimension of argument addr");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_addr = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_addr = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_addr))
      mexErrMsgTxt("Expecting numeric matrix for argument addr");
  }

  if (_n_dims(prhs[3]) > 0)
    mexErrMsgTxt("Error in dimension of argument cnt");

  if (!_check_input_vectorize(prhs[4], &_vec_n, _d, 0, &_vecstride_Termination))
    mexErrMsgTxt("Error in dimension of argument Termination");
  if (mxIsInt32(prhs[4]) || mxIsUint32(prhs[4]))
    _arg_Termination = (int *)mxGetData(prhs[4]);
   else
  {
    _arg_Termination = (int *)alloca(_arraylen(prhs[4]) * sizeof (int));
    if (!_get_numeric(prhs[4], _arg_Termination))
      mexErrMsgTxt("Expecting numeric matrix for argument Termination");
  }

  {
    int _ds[] = { _arg_cnt, _d[0] , _d[1] , _d[2]  };
    plhs[0] = mxCreateNumericArray(max((1 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxCOMPLEX);
    _arg_buffer = (void * *)alloca(_arraylen(plhs[0]) * sizeof (void *));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    Receive(_arg_boardID[_vecstride_boardID*_vidx], _arg_addr[_vecstride_addr*_vidx], &_arg_buffer[_arg_cnt*_vidx], _arg_cnt, _arg_Termination[_vecstride_Termination*_vidx]);
  }
  _put_pointer(plhs[0], (void **)_arg_buffer, 353986040); /* void * */
}

void _wrap_ReceiveSetup(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ReceiveSetup");
  int _arg_boardID;
  int _arg_addr;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument addr");
  if (!_get_numeric(prhs[2], &_arg_addr))
    mexErrMsgTxt("Expecting numeric scalar for argument addr");

    ReceiveSetup(_arg_boardID, _arg_addr);
}

void _wrap_ResetSys(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ResetSys");
  int _arg_boardID;
  int _arg_addrlist;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument addrlist");
  if (!_get_numeric(prhs[2], &_arg_addrlist))
    mexErrMsgTxt("Expecting numeric scalar for argument addrlist");

    ResetSys(_arg_boardID, &_arg_addrlist);
}

void _wrap_Send(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 5+1)
    mexErrMsgTxt("Wrong number of arguments to function Send");
  int _arg_boardID;
  int _arg_addr;
  char * _arg_databuf;
  int _arg_datacnt;
  int _arg_eotMode;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument addr");
  if (!_get_numeric(prhs[2], &_arg_addr))
    mexErrMsgTxt("Expecting numeric scalar for argument addr");

  if (_n_dims(prhs[3]) > 0)
    mexErrMsgTxt("Error in dimension of argument databuf");
  if (!mxIsChar(prhs[3]))
    mexErrMsgTxt("Expecting string for argument databuf");
  _arg_databuf = (char *)alloca((mxGetN(prhs[3]) + 1) * sizeof (char));
  mxGetString(prhs[3], _arg_databuf, mxGetN(prhs[3])+1);

  if (_n_dims(prhs[4]) > 0)
    mexErrMsgTxt("Error in dimension of argument datacnt");
  if (!_get_numeric(prhs[4], &_arg_datacnt))
    mexErrMsgTxt("Expecting numeric scalar for argument datacnt");

  if (_n_dims(prhs[5]) > 0)
    mexErrMsgTxt("Error in dimension of argument eotMode");
  if (!_get_numeric(prhs[5], &_arg_eotMode))
    mexErrMsgTxt("Expecting numeric scalar for argument eotMode");

    Send(_arg_boardID, _arg_addr, _arg_databuf, _arg_datacnt, _arg_eotMode);
}

void _wrap_SendCmds(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 3+1)
    mexErrMsgTxt("Wrong number of arguments to function SendCmds");
  int _arg_boardID;
  char * _arg_buffer;
  int _arg_cnt;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument buffer");
  if (!mxIsChar(prhs[2]))
    mexErrMsgTxt("Expecting string for argument buffer");
  _arg_buffer = (char *)alloca((mxGetN(prhs[2]) + 1) * sizeof (char));
  mxGetString(prhs[2], _arg_buffer, mxGetN(prhs[2])+1);

  if (_n_dims(prhs[3]) > 0)
    mexErrMsgTxt("Error in dimension of argument cnt");
  if (!_get_numeric(prhs[3], &_arg_cnt))
    mexErrMsgTxt("Expecting numeric scalar for argument cnt");

    SendCmds(_arg_boardID, _arg_buffer, _arg_cnt);
}

void _wrap_SendDataBytes(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 4+1)
    mexErrMsgTxt("Wrong number of arguments to function SendDataBytes");
  int _arg_boardID;
  char * _arg_buffer;
  int _arg_cnt;
  int _arg_eot_mode;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument buffer");
  if (!mxIsChar(prhs[2]))
    mexErrMsgTxt("Expecting string for argument buffer");
  _arg_buffer = (char *)alloca((mxGetN(prhs[2]) + 1) * sizeof (char));
  mxGetString(prhs[2], _arg_buffer, mxGetN(prhs[2])+1);

  if (_n_dims(prhs[3]) > 0)
    mexErrMsgTxt("Error in dimension of argument cnt");
  if (!_get_numeric(prhs[3], &_arg_cnt))
    mexErrMsgTxt("Expecting numeric scalar for argument cnt");

  if (_n_dims(prhs[4]) > 0)
    mexErrMsgTxt("Error in dimension of argument eot_mode");
  if (!_get_numeric(prhs[4], &_arg_eot_mode))
    mexErrMsgTxt("Expecting numeric scalar for argument eot_mode");

    SendDataBytes(_arg_boardID, _arg_buffer, _arg_cnt, _arg_eot_mode);
}

void _wrap_SendIFC(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 1+1)
    mexErrMsgTxt("Wrong number of arguments to function SendIFC");
  int _arg_boardID;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

    SendIFC(_arg_boardID);
}

void _wrap_SendLLO(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 1+1)
    mexErrMsgTxt("Wrong number of arguments to function SendLLO");
  int _arg_boardID;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

    SendLLO(_arg_boardID);
}

void _wrap_SendList(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 5+1)
    mexErrMsgTxt("Wrong number of arguments to function SendList");
  int _arg_boardID;
  int _arg_addrlist;
  char * _arg_databuf;
  int _arg_datacnt;
  int _arg_eotMode;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument addrlist");
  if (!_get_numeric(prhs[2], &_arg_addrlist))
    mexErrMsgTxt("Expecting numeric scalar for argument addrlist");

  if (_n_dims(prhs[3]) > 0)
    mexErrMsgTxt("Error in dimension of argument databuf");
  if (!mxIsChar(prhs[3]))
    mexErrMsgTxt("Expecting string for argument databuf");
  _arg_databuf = (char *)alloca((mxGetN(prhs[3]) + 1) * sizeof (char));
  mxGetString(prhs[3], _arg_databuf, mxGetN(prhs[3])+1);

  if (_n_dims(prhs[4]) > 0)
    mexErrMsgTxt("Error in dimension of argument datacnt");
  if (!_get_numeric(prhs[4], &_arg_datacnt))
    mexErrMsgTxt("Expecting numeric scalar for argument datacnt");

  if (_n_dims(prhs[5]) > 0)
    mexErrMsgTxt("Error in dimension of argument eotMode");
  if (!_get_numeric(prhs[5], &_arg_eotMode))
    mexErrMsgTxt("Expecting numeric scalar for argument eotMode");

    SendList(_arg_boardID, &_arg_addrlist, _arg_databuf, _arg_datacnt, _arg_eotMode);
}

void _wrap_SendSetup(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function SendSetup");
  int _arg_boardID;
  int _arg_addrlist;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument addrlist");
  if (!_get_numeric(prhs[2], &_arg_addrlist))
    mexErrMsgTxt("Expecting numeric scalar for argument addrlist");

    SendSetup(_arg_boardID, &_arg_addrlist);
}

void _wrap_SetRWLS(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function SetRWLS");
  int _arg_boardID;
  int _arg_addrlist;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument addrlist");
  if (!_get_numeric(prhs[2], &_arg_addrlist))
    mexErrMsgTxt("Expecting numeric scalar for argument addrlist");

    SetRWLS(_arg_boardID, &_arg_addrlist);
}

void _wrap_TestSRQ(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 1+1)
    mexErrMsgTxt("Wrong number of arguments to function TestSRQ");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_boardID;
  int *_arg_result;
  int _vecstride_boardID = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_boardID))
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_boardID = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_boardID = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_boardID))
      mexErrMsgTxt("Expecting numeric matrix for argument boardID");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_result = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    TestSRQ(_arg_boardID[_vecstride_boardID*_vidx], &_arg_result[_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_result++;
  }
}

void _wrap_TestSys(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function TestSys");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_boardID;
  int *_arg_addrlist;
  int *_arg_results;
  int _vecstride_boardID = 1;
  int _vecstride_addrlist = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_boardID))
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_boardID = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_boardID = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_boardID))
      mexErrMsgTxt("Expecting numeric matrix for argument boardID");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_addrlist))
    mexErrMsgTxt("Error in dimension of argument addrlist");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_addrlist = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_addrlist = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_addrlist))
      mexErrMsgTxt("Expecting numeric matrix for argument addrlist");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_results = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    TestSys(_arg_boardID[_vecstride_boardID*_vidx], &_arg_addrlist[_vecstride_addrlist*_vidx], &_arg_results[_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_results++;
  }
}

void _wrap_ThreadIbcnt(int nlhs, mxArray **plhs, int nrhs, const mxArray **)
{
  if (nlhs > 1 ||
      nrhs != 0+1)
    mexErrMsgTxt("Wrong number of arguments to function ThreadIbcnt");
  int _arg_retval;
  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
    _arg_retval =
      ThreadIbcnt();
  *mxGetPr(plhs[0]) = (double)_arg_retval;
}

void _wrap_ThreadIbcntl(int nlhs, mxArray **plhs, int nrhs, const mxArray **)
{
  if (nlhs > 1 ||
      nrhs != 0+1)
    mexErrMsgTxt("Wrong number of arguments to function ThreadIbcntl");
  int _arg_retval;
  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
    _arg_retval =
      ThreadIbcntl();
  *mxGetPr(plhs[0]) = (double)_arg_retval;
}

void _wrap_ThreadIberr(int nlhs, mxArray **plhs, int nrhs, const mxArray **)
{
  if (nlhs > 1 ||
      nrhs != 0+1)
    mexErrMsgTxt("Wrong number of arguments to function ThreadIberr");
  int _arg_retval;
  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
    _arg_retval =
      ThreadIberr();
  *mxGetPr(plhs[0]) = (double)_arg_retval;
}

void _wrap_ThreadIbsta(int nlhs, mxArray **plhs, int nrhs, const mxArray **)
{
  if (nlhs > 1 ||
      nrhs != 0+1)
    mexErrMsgTxt("Wrong number of arguments to function ThreadIbsta");
  int _arg_retval;
  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
    _arg_retval =
      ThreadIbsta();
  *mxGetPr(plhs[0]) = (double)_arg_retval;
}

void _wrap_Trigger(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function Trigger");
  int _arg_boardID;
  int _arg_addr;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument addr");
  if (!_get_numeric(prhs[2], &_arg_addr))
    mexErrMsgTxt("Expecting numeric scalar for argument addr");

    Trigger(_arg_boardID, _arg_addr);
}

void _wrap_TriggerList(int nlhs, mxArray **, int nrhs, const mxArray **prhs)
{
  if (nlhs != 0 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function TriggerList");
  int _arg_boardID;
  int _arg_addrlist;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (!_get_numeric(prhs[1], &_arg_boardID))
    mexErrMsgTxt("Expecting numeric scalar for argument boardID");

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument addrlist");
  if (!_get_numeric(prhs[2], &_arg_addrlist))
    mexErrMsgTxt("Expecting numeric scalar for argument addrlist");

    TriggerList(_arg_boardID, &_arg_addrlist);
}

void _wrap_WaitSRQ(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 1+1)
    mexErrMsgTxt("Wrong number of arguments to function WaitSRQ");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_boardID;
  int *_arg_result;
  int _vecstride_boardID = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_boardID))
    mexErrMsgTxt("Error in dimension of argument boardID");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_boardID = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_boardID = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_boardID))
      mexErrMsgTxt("Expecting numeric matrix for argument boardID");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_result = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    WaitSRQ(_arg_boardID[_vecstride_boardID*_vidx], &_arg_result[_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_result++;
  }
}

void _wrap_ibask(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs != 2 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibask");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_option;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_option = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_option))
    mexErrMsgTxt("Error in dimension of argument option");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_option = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_option = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_option))
      mexErrMsgTxt("Expecting numeric matrix for argument option");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[1] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_v = (int *)alloca(_arraylen(plhs[1]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibask(_arg_ud[_vecstride_ud*_vidx], _arg_option[_vecstride_option*_vidx], &_arg_v[_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[1]);
    for (_fidx = 0; _fidx < _arraylen(plhs[1]); ++_fidx)
      *d_ptr++ = (double)*_arg_v++;
  }
}

void _wrap_ibbna(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibbna");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  char * _arg_udname;
  int *_arg_retval;
  int _vecstride_ud = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument udname");
  if (!mxIsChar(prhs[2]))
    mexErrMsgTxt("Expecting string for argument udname");
  _arg_udname = (char *)alloca((mxGetN(prhs[2]) + 1) * sizeof (char));
  mxGetString(prhs[2], _arg_udname, mxGetN(prhs[2])+1);

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibbna(_arg_ud[_vecstride_ud*_vidx], _arg_udname);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibcac(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibcac");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_v = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_v))
    mexErrMsgTxt("Error in dimension of argument v");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_v = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_v = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_v))
      mexErrMsgTxt("Expecting numeric matrix for argument v");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibcac(_arg_ud[_vecstride_ud*_vidx], _arg_v[_vecstride_v*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibclr(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 1+1)
    mexErrMsgTxt("Wrong number of arguments to function ibclr");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_retval;
  int _vecstride_ud = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibclr(_arg_ud[_vecstride_ud*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibcmd(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 3+1)
    mexErrMsgTxt("Wrong number of arguments to function ibcmd");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  char * _arg_buf;
  int *_arg_cnt;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_cnt = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument buf");
  if (!mxIsChar(prhs[2]))
    mexErrMsgTxt("Expecting string for argument buf");
  _arg_buf = (char *)alloca((mxGetN(prhs[2]) + 1) * sizeof (char));
  mxGetString(prhs[2], _arg_buf, mxGetN(prhs[2])+1);

  if (!_check_input_vectorize(prhs[3], &_vec_n, _d, 0, &_vecstride_cnt))
    mexErrMsgTxt("Error in dimension of argument cnt");
  if (mxIsInt32(prhs[3]) || mxIsUint32(prhs[3]))
    _arg_cnt = (int *)mxGetData(prhs[3]);
   else
  {
    _arg_cnt = (int *)alloca(_arraylen(prhs[3]) * sizeof (int));
    if (!_get_numeric(prhs[3], _arg_cnt))
      mexErrMsgTxt("Expecting numeric matrix for argument cnt");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibcmd(_arg_ud[_vecstride_ud*_vidx], _arg_buf, _arg_cnt[_vecstride_cnt*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibcmda(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 3+1)
    mexErrMsgTxt("Wrong number of arguments to function ibcmda");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  char * _arg_buf;
  int *_arg_cnt;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_cnt = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument buf");
  if (!mxIsChar(prhs[2]))
    mexErrMsgTxt("Expecting string for argument buf");
  _arg_buf = (char *)alloca((mxGetN(prhs[2]) + 1) * sizeof (char));
  mxGetString(prhs[2], _arg_buf, mxGetN(prhs[2])+1);

  if (!_check_input_vectorize(prhs[3], &_vec_n, _d, 0, &_vecstride_cnt))
    mexErrMsgTxt("Error in dimension of argument cnt");
  if (mxIsInt32(prhs[3]) || mxIsUint32(prhs[3]))
    _arg_cnt = (int *)mxGetData(prhs[3]);
   else
  {
    _arg_cnt = (int *)alloca(_arraylen(prhs[3]) * sizeof (int));
    if (!_get_numeric(prhs[3], _arg_cnt))
      mexErrMsgTxt("Expecting numeric matrix for argument cnt");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibcmda(_arg_ud[_vecstride_ud*_vidx], _arg_buf, _arg_cnt[_vecstride_cnt*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibconfig(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 3+1)
    mexErrMsgTxt("Wrong number of arguments to function ibconfig");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_option;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_option = 1;
  int _vecstride_v = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_option))
    mexErrMsgTxt("Error in dimension of argument option");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_option = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_option = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_option))
      mexErrMsgTxt("Expecting numeric matrix for argument option");
  }

  if (!_check_input_vectorize(prhs[3], &_vec_n, _d, 0, &_vecstride_v))
    mexErrMsgTxt("Error in dimension of argument v");
  if (mxIsInt32(prhs[3]) || mxIsUint32(prhs[3]))
    _arg_v = (int *)mxGetData(prhs[3]);
   else
  {
    _arg_v = (int *)alloca(_arraylen(prhs[3]) * sizeof (int));
    if (!_get_numeric(prhs[3], _arg_v))
      mexErrMsgTxt("Expecting numeric matrix for argument v");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibconfig(_arg_ud[_vecstride_ud*_vidx], _arg_option[_vecstride_option*_vidx], _arg_v[_vecstride_v*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibdev(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 6+1)
    mexErrMsgTxt("Wrong number of arguments to function ibdev");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_pad;
  int *_arg_sad;
  int *_arg_tmo;
  int *_arg_eot;
  int *_arg_eos;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_pad = 1;
  int _vecstride_sad = 1;
  int _vecstride_tmo = 1;
  int _vecstride_eot = 1;
  int _vecstride_eos = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_pad))
    mexErrMsgTxt("Error in dimension of argument pad");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_pad = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_pad = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_pad))
      mexErrMsgTxt("Expecting numeric matrix for argument pad");
  }

  if (!_check_input_vectorize(prhs[3], &_vec_n, _d, 0, &_vecstride_sad))
    mexErrMsgTxt("Error in dimension of argument sad");
  if (mxIsInt32(prhs[3]) || mxIsUint32(prhs[3]))
    _arg_sad = (int *)mxGetData(prhs[3]);
   else
  {
    _arg_sad = (int *)alloca(_arraylen(prhs[3]) * sizeof (int));
    if (!_get_numeric(prhs[3], _arg_sad))
      mexErrMsgTxt("Expecting numeric matrix for argument sad");
  }

  if (!_check_input_vectorize(prhs[4], &_vec_n, _d, 0, &_vecstride_tmo))
    mexErrMsgTxt("Error in dimension of argument tmo");
  if (mxIsInt32(prhs[4]) || mxIsUint32(prhs[4]))
    _arg_tmo = (int *)mxGetData(prhs[4]);
   else
  {
    _arg_tmo = (int *)alloca(_arraylen(prhs[4]) * sizeof (int));
    if (!_get_numeric(prhs[4], _arg_tmo))
      mexErrMsgTxt("Expecting numeric matrix for argument tmo");
  }

  if (!_check_input_vectorize(prhs[5], &_vec_n, _d, 0, &_vecstride_eot))
    mexErrMsgTxt("Error in dimension of argument eot");
  if (mxIsInt32(prhs[5]) || mxIsUint32(prhs[5]))
    _arg_eot = (int *)mxGetData(prhs[5]);
   else
  {
    _arg_eot = (int *)alloca(_arraylen(prhs[5]) * sizeof (int));
    if (!_get_numeric(prhs[5], _arg_eot))
      mexErrMsgTxt("Expecting numeric matrix for argument eot");
  }

  if (!_check_input_vectorize(prhs[6], &_vec_n, _d, 0, &_vecstride_eos))
    mexErrMsgTxt("Error in dimension of argument eos");
  if (mxIsInt32(prhs[6]) || mxIsUint32(prhs[6]))
    _arg_eos = (int *)mxGetData(prhs[6]);
   else
  {
    _arg_eos = (int *)alloca(_arraylen(prhs[6]) * sizeof (int));
    if (!_get_numeric(prhs[6], _arg_eos))
      mexErrMsgTxt("Expecting numeric matrix for argument eos");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibdev(_arg_ud[_vecstride_ud*_vidx], _arg_pad[_vecstride_pad*_vidx], _arg_sad[_vecstride_sad*_vidx], _arg_tmo[_vecstride_tmo*_vidx], _arg_eot[_vecstride_eot*_vidx], _arg_eos[_vecstride_eos*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibdma(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibdma");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_v = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_v))
    mexErrMsgTxt("Error in dimension of argument v");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_v = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_v = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_v))
      mexErrMsgTxt("Expecting numeric matrix for argument v");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibdma(_arg_ud[_vecstride_ud*_vidx], _arg_v[_vecstride_v*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibeos(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibeos");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_v = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_v))
    mexErrMsgTxt("Error in dimension of argument v");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_v = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_v = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_v))
      mexErrMsgTxt("Expecting numeric matrix for argument v");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibeos(_arg_ud[_vecstride_ud*_vidx], _arg_v[_vecstride_v*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibeot(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibeot");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_v = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_v))
    mexErrMsgTxt("Error in dimension of argument v");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_v = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_v = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_v))
      mexErrMsgTxt("Expecting numeric matrix for argument v");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibeot(_arg_ud[_vecstride_ud*_vidx], _arg_v[_vecstride_v*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibfind(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 1+1)
    mexErrMsgTxt("Wrong number of arguments to function ibfind");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  char * _arg_udname;
  int *_arg_retval;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument udname");
  if (!mxIsChar(prhs[1]))
    mexErrMsgTxt("Expecting string for argument udname");
  _arg_udname = (char *)alloca((mxGetN(prhs[1]) + 1) * sizeof (char));
  mxGetString(prhs[1], _arg_udname, mxGetN(prhs[1])+1);

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibfind(_arg_udname);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibgts(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibgts");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_v = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_v))
    mexErrMsgTxt("Error in dimension of argument v");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_v = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_v = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_v))
      mexErrMsgTxt("Expecting numeric matrix for argument v");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibgts(_arg_ud[_vecstride_ud*_vidx], _arg_v[_vecstride_v*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibist(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibist");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_v = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_v))
    mexErrMsgTxt("Error in dimension of argument v");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_v = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_v = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_v))
      mexErrMsgTxt("Expecting numeric matrix for argument v");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibist(_arg_ud[_vecstride_ud*_vidx], _arg_v[_vecstride_v*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_iblines(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs != 2 ||
      nrhs != 1+1)
    mexErrMsgTxt("Wrong number of arguments to function iblines");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_result;
  int *_arg_retval;
  int _vecstride_ud = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[1] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_result = (int *)alloca(_arraylen(plhs[1]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      iblines(_arg_ud[_vecstride_ud*_vidx], &_arg_result[_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[1]);
    for (_fidx = 0; _fidx < _arraylen(plhs[1]); ++_fidx)
      *d_ptr++ = (double)*_arg_result++;
  }
}

void _wrap_ibln(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs != 2 ||
      nrhs != 3+1)
    mexErrMsgTxt("Wrong number of arguments to function ibln");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_pad;
  int *_arg_sad;
  int *_arg_listen;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_pad = 1;
  int _vecstride_sad = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_pad))
    mexErrMsgTxt("Error in dimension of argument pad");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_pad = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_pad = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_pad))
      mexErrMsgTxt("Expecting numeric matrix for argument pad");
  }

  if (!_check_input_vectorize(prhs[3], &_vec_n, _d, 0, &_vecstride_sad))
    mexErrMsgTxt("Error in dimension of argument sad");
  if (mxIsInt32(prhs[3]) || mxIsUint32(prhs[3]))
    _arg_sad = (int *)mxGetData(prhs[3]);
   else
  {
    _arg_sad = (int *)alloca(_arraylen(prhs[3]) * sizeof (int));
    if (!_get_numeric(prhs[3], _arg_sad))
      mexErrMsgTxt("Expecting numeric matrix for argument sad");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[1] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_listen = (int *)alloca(_arraylen(plhs[1]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibln(_arg_ud[_vecstride_ud*_vidx], _arg_pad[_vecstride_pad*_vidx], _arg_sad[_vecstride_sad*_vidx], &_arg_listen[_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[1]);
    for (_fidx = 0; _fidx < _arraylen(plhs[1]); ++_fidx)
      *d_ptr++ = (double)*_arg_listen++;
  }
}

void _wrap_ibloc(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 1+1)
    mexErrMsgTxt("Wrong number of arguments to function ibloc");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_retval;
  int _vecstride_ud = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibloc(_arg_ud[_vecstride_ud*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibonl(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibonl");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_v = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_v))
    mexErrMsgTxt("Error in dimension of argument v");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_v = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_v = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_v))
      mexErrMsgTxt("Expecting numeric matrix for argument v");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibonl(_arg_ud[_vecstride_ud*_vidx], _arg_v[_vecstride_v*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibpad(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibpad");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_v = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_v))
    mexErrMsgTxt("Error in dimension of argument v");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_v = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_v = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_v))
      mexErrMsgTxt("Expecting numeric matrix for argument v");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibpad(_arg_ud[_vecstride_ud*_vidx], _arg_v[_vecstride_v*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibpct(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 1+1)
    mexErrMsgTxt("Wrong number of arguments to function ibpct");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_retval;
  int _vecstride_ud = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibpct(_arg_ud[_vecstride_ud*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibpoke(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 3+1)
    mexErrMsgTxt("Wrong number of arguments to function ibpoke");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_option;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_option = 1;
  int _vecstride_v = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_option))
    mexErrMsgTxt("Error in dimension of argument option");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_option = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_option = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_option))
      mexErrMsgTxt("Expecting numeric matrix for argument option");
  }

  if (!_check_input_vectorize(prhs[3], &_vec_n, _d, 0, &_vecstride_v))
    mexErrMsgTxt("Error in dimension of argument v");
  if (mxIsInt32(prhs[3]) || mxIsUint32(prhs[3]))
    _arg_v = (int *)mxGetData(prhs[3]);
   else
  {
    _arg_v = (int *)alloca(_arraylen(prhs[3]) * sizeof (int));
    if (!_get_numeric(prhs[3], _arg_v))
      mexErrMsgTxt("Expecting numeric matrix for argument v");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibpoke(_arg_ud[_vecstride_ud*_vidx], _arg_option[_vecstride_option*_vidx], _arg_v[_vecstride_v*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibppc(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibppc");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_v = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_v))
    mexErrMsgTxt("Error in dimension of argument v");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_v = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_v = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_v))
      mexErrMsgTxt("Expecting numeric matrix for argument v");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibppc(_arg_ud[_vecstride_ud*_vidx], _arg_v[_vecstride_v*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibrd(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs != 2 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibrd");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  void * *_arg_buf;
  int _arg_cnt;
  int *_arg_retval;
  if (!_get_numeric(prhs[2], &_arg_cnt))
    mexErrMsgTxt("Expecting numeric scalar for argument cnt");
  int _vecstride_ud = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument cnt");

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  {
    int _ds[] = { _arg_cnt, _d[0] , _d[1] , _d[2]  };
    plhs[1] = mxCreateNumericArray(max((1 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxCOMPLEX);
    _arg_buf = (void * *)alloca(_arraylen(plhs[1]) * sizeof (void *));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibrd(_arg_ud[_vecstride_ud*_vidx], &_arg_buf[_arg_cnt*_vidx], _arg_cnt);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
  _put_pointer(plhs[1], (void **)_arg_buf, 353986040); /* void * */
}

void _wrap_ibrda(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs != 2 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibrda");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  void * *_arg_buf;
  int _arg_cnt;
  int *_arg_retval;
  if (!_get_numeric(prhs[2], &_arg_cnt))
    mexErrMsgTxt("Expecting numeric scalar for argument cnt");
  int _vecstride_ud = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument cnt");

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  {
    int _ds[] = { _arg_cnt, _d[0] , _d[1] , _d[2]  };
    plhs[1] = mxCreateNumericArray(max((1 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxCOMPLEX);
    _arg_buf = (void * *)alloca(_arraylen(plhs[1]) * sizeof (void *));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibrda(_arg_ud[_vecstride_ud*_vidx], &_arg_buf[_arg_cnt*_vidx], _arg_cnt);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
  _put_pointer(plhs[1], (void **)_arg_buf, 353986040); /* void * */
}

void _wrap_ibrdf(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibrdf");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  char * _arg_filename;
  int *_arg_retval;
  int _vecstride_ud = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument filename");
  if (!mxIsChar(prhs[2]))
    mexErrMsgTxt("Expecting string for argument filename");
  _arg_filename = (char *)alloca((mxGetN(prhs[2]) + 1) * sizeof (char));
  mxGetString(prhs[2], _arg_filename, mxGetN(prhs[2])+1);

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibrdf(_arg_ud[_vecstride_ud*_vidx], _arg_filename);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibrpp(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs != 2 ||
      nrhs != 1+1)
    mexErrMsgTxt("Wrong number of arguments to function ibrpp");
  int _arg_ud;
  char _arg_ppr;
  int _arg_retval;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument ud");
  if (!_get_numeric(prhs[1], &_arg_ud))
    mexErrMsgTxt("Expecting numeric scalar for argument ud");

  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
  plhs[1] = mxCreateCharArray(1, scalar_dimensions);
    _arg_retval =
      ibrpp(_arg_ud, &_arg_ppr);
  *mxGetPr(plhs[0]) = (double)_arg_retval;
  *(char *)mxGetPr(plhs[1]) = _arg_ppr;
}

void _wrap_ibrsc(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibrsc");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_v = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_v))
    mexErrMsgTxt("Error in dimension of argument v");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_v = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_v = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_v))
      mexErrMsgTxt("Expecting numeric matrix for argument v");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibrsc(_arg_ud[_vecstride_ud*_vidx], _arg_v[_vecstride_v*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibrsp(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs != 2 ||
      nrhs != 1+1)
    mexErrMsgTxt("Wrong number of arguments to function ibrsp");
  int _arg_ud;
  char _arg_spr;
  int _arg_retval;
  if (_n_dims(prhs[1]) > 0)
    mexErrMsgTxt("Error in dimension of argument ud");
  if (!_get_numeric(prhs[1], &_arg_ud))
    mexErrMsgTxt("Expecting numeric scalar for argument ud");

  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
  plhs[1] = mxCreateCharArray(1, scalar_dimensions);
    _arg_retval =
      ibrsp(_arg_ud, &_arg_spr);
  *mxGetPr(plhs[0]) = (double)_arg_retval;
  *(char *)mxGetPr(plhs[1]) = _arg_spr;
}

void _wrap_ibrsv(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibrsv");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_v = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_v))
    mexErrMsgTxt("Error in dimension of argument v");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_v = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_v = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_v))
      mexErrMsgTxt("Expecting numeric matrix for argument v");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibrsv(_arg_ud[_vecstride_ud*_vidx], _arg_v[_vecstride_v*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibsad(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibsad");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_v = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_v))
    mexErrMsgTxt("Error in dimension of argument v");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_v = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_v = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_v))
      mexErrMsgTxt("Expecting numeric matrix for argument v");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibsad(_arg_ud[_vecstride_ud*_vidx], _arg_v[_vecstride_v*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibsic(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 1+1)
    mexErrMsgTxt("Wrong number of arguments to function ibsic");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_retval;
  int _vecstride_ud = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibsic(_arg_ud[_vecstride_ud*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibsre(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibsre");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_v = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_v))
    mexErrMsgTxt("Error in dimension of argument v");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_v = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_v = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_v))
      mexErrMsgTxt("Expecting numeric matrix for argument v");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibsre(_arg_ud[_vecstride_ud*_vidx], _arg_v[_vecstride_v*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibstop(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 1+1)
    mexErrMsgTxt("Wrong number of arguments to function ibstop");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_retval;
  int _vecstride_ud = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibstop(_arg_ud[_vecstride_ud*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibtmo(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibtmo");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_v;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_v = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_v))
    mexErrMsgTxt("Error in dimension of argument v");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_v = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_v = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_v))
      mexErrMsgTxt("Expecting numeric matrix for argument v");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibtmo(_arg_ud[_vecstride_ud*_vidx], _arg_v[_vecstride_v*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibtrg(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 1+1)
    mexErrMsgTxt("Wrong number of arguments to function ibtrg");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_retval;
  int _vecstride_ud = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibtrg(_arg_ud[_vecstride_ud*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibwait(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibwait");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  int *_arg_mask;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_mask = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (!_check_input_vectorize(prhs[2], &_vec_n, _d, 0, &_vecstride_mask))
    mexErrMsgTxt("Error in dimension of argument mask");
  if (mxIsInt32(prhs[2]) || mxIsUint32(prhs[2]))
    _arg_mask = (int *)mxGetData(prhs[2]);
   else
  {
    _arg_mask = (int *)alloca(_arraylen(prhs[2]) * sizeof (int));
    if (!_get_numeric(prhs[2], _arg_mask))
      mexErrMsgTxt("Expecting numeric matrix for argument mask");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibwait(_arg_ud[_vecstride_ud*_vidx], _arg_mask[_vecstride_mask*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibwrt(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 3+1)
    mexErrMsgTxt("Wrong number of arguments to function ibwrt");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  char * _arg_buf;
  int *_arg_cnt;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_cnt = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument buf");
  if (!mxIsChar(prhs[2]))
    mexErrMsgTxt("Expecting string for argument buf");
  _arg_buf = (char *)alloca((mxGetN(prhs[2]) + 1) * sizeof (char));
  mxGetString(prhs[2], _arg_buf, mxGetN(prhs[2])+1);

  if (!_check_input_vectorize(prhs[3], &_vec_n, _d, 0, &_vecstride_cnt))
    mexErrMsgTxt("Error in dimension of argument cnt");
  if (mxIsInt32(prhs[3]) || mxIsUint32(prhs[3]))
    _arg_cnt = (int *)mxGetData(prhs[3]);
   else
  {
    _arg_cnt = (int *)alloca(_arraylen(prhs[3]) * sizeof (int));
    if (!_get_numeric(prhs[3], _arg_cnt))
      mexErrMsgTxt("Expecting numeric matrix for argument cnt");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibwrt(_arg_ud[_vecstride_ud*_vidx], _arg_buf, _arg_cnt[_vecstride_cnt*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibwrta(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 3+1)
    mexErrMsgTxt("Wrong number of arguments to function ibwrta");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  char * _arg_buf;
  int *_arg_cnt;
  int *_arg_retval;
  int _vecstride_ud = 1;
  int _vecstride_cnt = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument buf");
  if (!mxIsChar(prhs[2]))
    mexErrMsgTxt("Expecting string for argument buf");
  _arg_buf = (char *)alloca((mxGetN(prhs[2]) + 1) * sizeof (char));
  mxGetString(prhs[2], _arg_buf, mxGetN(prhs[2])+1);

  if (!_check_input_vectorize(prhs[3], &_vec_n, _d, 0, &_vecstride_cnt))
    mexErrMsgTxt("Error in dimension of argument cnt");
  if (mxIsInt32(prhs[3]) || mxIsUint32(prhs[3]))
    _arg_cnt = (int *)mxGetData(prhs[3]);
   else
  {
    _arg_cnt = (int *)alloca(_arraylen(prhs[3]) * sizeof (int));
    if (!_get_numeric(prhs[3], _arg_cnt))
      mexErrMsgTxt("Expecting numeric matrix for argument cnt");
  }

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibwrta(_arg_ud[_vecstride_ud*_vidx], _arg_buf, _arg_cnt[_vecstride_cnt*_vidx]);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_ibwrtf(int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs)
{
  if (nlhs > 1 ||
      nrhs != 2+1)
    mexErrMsgTxt("Wrong number of arguments to function ibwrtf");
  int _d[4] = { 1,1,1,1 };
  int _vec_n = 0;
  int _vidx;
  int _vec_sz;
  int *_arg_ud;
  char * _arg_filename;
  int *_arg_retval;
  int _vecstride_ud = 1;
  if (!_check_input_vectorize(prhs[1], &_vec_n, _d, 0, &_vecstride_ud))
    mexErrMsgTxt("Error in dimension of argument ud");
  if (mxIsInt32(prhs[1]) || mxIsUint32(prhs[1]))
    _arg_ud = (int *)mxGetData(prhs[1]);
   else
  {
    _arg_ud = (int *)alloca(_arraylen(prhs[1]) * sizeof (int));
    if (!_get_numeric(prhs[1], _arg_ud))
      mexErrMsgTxt("Expecting numeric matrix for argument ud");
  }

  if (_n_dims(prhs[2]) > 0)
    mexErrMsgTxt("Error in dimension of argument filename");
  if (!mxIsChar(prhs[2]))
    mexErrMsgTxt("Expecting string for argument filename");
  _arg_filename = (char *)alloca((mxGetN(prhs[2]) + 1) * sizeof (char));
  mxGetString(prhs[2], _arg_filename, mxGetN(prhs[2])+1);

  {
    int _ds[] = { _d[0] , _d[1] , _d[2] , _d[3]  };
    plhs[0] = mxCreateNumericArray(max((0 + _vec_n), 2), _ds, mxDOUBLE_CLASS, mxREAL);
    _arg_retval = (int *)alloca(_arraylen(plhs[0]) * sizeof (int));
  }
  _vec_sz = _d[0]*_d[1]*_d[2]*_d[3];
  for (_vidx = 0; _vidx < _vec_sz; ++_vidx) {
    _arg_retval[_vidx] =
      ibwrtf(_arg_ud[_vecstride_ud*_vidx], _arg_filename);
  }
  {
    int _fidx;
    double *d_ptr = mxGetPr(plhs[0]);
    for (_fidx = 0; _fidx < _arraylen(plhs[0]); ++_fidx)
      *d_ptr++ = (double)*_arg_retval++;
  }
}

void _wrap_user_ibcnt(int nlhs, mxArray **plhs, int nrhs, const mxArray **)
{
  if (nlhs > 1 ||
      nrhs != 0+1)
    mexErrMsgTxt("Wrong number of arguments to function user_ibcnt");
  int _arg_retval;
  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
    _arg_retval =
      ibcnt;
  *mxGetPr(plhs[0]) = (double)_arg_retval;
}

void _wrap_user_ibcntl(int nlhs, mxArray **plhs, int nrhs, const mxArray **)
{
  if (nlhs > 1 ||
      nrhs != 0+1)
    mexErrMsgTxt("Wrong number of arguments to function user_ibcntl");
  int _arg_retval;
  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
    _arg_retval =
      ibcntl;
  *mxGetPr(plhs[0]) = (double)_arg_retval;
}

void _wrap_user_iberr(int nlhs, mxArray **plhs, int nrhs, const mxArray **)
{
  if (nlhs > 1 ||
      nrhs != 0+1)
    mexErrMsgTxt("Wrong number of arguments to function user_iberr");
  int _arg_retval;
  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
    _arg_retval =
      iberr;
  *mxGetPr(plhs[0]) = (double)_arg_retval;
}

void _wrap_user_ibsta(int nlhs, mxArray **plhs, int nrhs, const mxArray **)
{
  if (nlhs > 1 ||
      nrhs != 0+1)
    mexErrMsgTxt("Wrong number of arguments to function user_ibsta");
  int _arg_retval;
  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
    _arg_retval =
      ibsta;
  *mxGetPr(plhs[0]) = (double)_arg_retval;
}



/*
 * The main dispatch function.  This function calls the appropriate wrapper
 * based on the value of the first argument.
 */

#ifdef __cplusplus
extern "C" {
#endif

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
  if (nrhs == 0 || !mxIsDouble(prhs[0]) ||
      mxGetM(prhs[0]) != 1 || mxGetN(prhs[0]) != 1)
    mexErrMsgTxt("Illegal call to mex functions in gpib1");
  switch ((int)(mxGetScalar(prhs[0]))) {
  case 0: _wrap_AllSpoll(nlhs, plhs, nrhs, prhs); break;
  case 1: _wrap_DevClear(nlhs, plhs, nrhs, prhs); break;
  case 2: _wrap_DevClearList(nlhs, plhs, nrhs, prhs); break;
  case 3: _wrap_EnableLocal(nlhs, plhs, nrhs, prhs); break;
  case 4: _wrap_EnableRemote(nlhs, plhs, nrhs, prhs); break;
  case 5: _wrap_FindLstn(nlhs, plhs, nrhs, prhs); break;
  case 6: _wrap_FindRQS(nlhs, plhs, nrhs, prhs); break;
  case 7: _wrap_PPoll(nlhs, plhs, nrhs, prhs); break;
  case 8: _wrap_PPollConfig(nlhs, plhs, nrhs, prhs); break;
  case 9: _wrap_PPollUnconfig(nlhs, plhs, nrhs, prhs); break;
  case 10: _wrap_PassControl(nlhs, plhs, nrhs, prhs); break;
  case 11: _wrap_RcvRespMsg(nlhs, plhs, nrhs, prhs); break;
  case 12: _wrap_ReadStatusByte(nlhs, plhs, nrhs, prhs); break;
  case 13: _wrap_Receive(nlhs, plhs, nrhs, prhs); break;
  case 14: _wrap_ReceiveSetup(nlhs, plhs, nrhs, prhs); break;
  case 15: _wrap_ResetSys(nlhs, plhs, nrhs, prhs); break;
  case 16: _wrap_Send(nlhs, plhs, nrhs, prhs); break;
  case 17: _wrap_SendCmds(nlhs, plhs, nrhs, prhs); break;
  case 18: _wrap_SendDataBytes(nlhs, plhs, nrhs, prhs); break;
  case 19: _wrap_SendIFC(nlhs, plhs, nrhs, prhs); break;
  case 20: _wrap_SendLLO(nlhs, plhs, nrhs, prhs); break;
  case 21: _wrap_SendList(nlhs, plhs, nrhs, prhs); break;
  case 22: _wrap_SendSetup(nlhs, plhs, nrhs, prhs); break;
  case 23: _wrap_SetRWLS(nlhs, plhs, nrhs, prhs); break;
  case 24: _wrap_TestSRQ(nlhs, plhs, nrhs, prhs); break;
  case 25: _wrap_TestSys(nlhs, plhs, nrhs, prhs); break;
  case 26: _wrap_ThreadIbcnt(nlhs, plhs, nrhs, prhs); break;
  case 27: _wrap_ThreadIbcntl(nlhs, plhs, nrhs, prhs); break;
  case 28: _wrap_ThreadIberr(nlhs, plhs, nrhs, prhs); break;
  case 29: _wrap_ThreadIbsta(nlhs, plhs, nrhs, prhs); break;
  case 30: _wrap_Trigger(nlhs, plhs, nrhs, prhs); break;
  case 31: _wrap_TriggerList(nlhs, plhs, nrhs, prhs); break;
  case 32: _wrap_WaitSRQ(nlhs, plhs, nrhs, prhs); break;
  case 33: _wrap_ibask(nlhs, plhs, nrhs, prhs); break;
  case 34: _wrap_ibbna(nlhs, plhs, nrhs, prhs); break;
  case 35: _wrap_ibcac(nlhs, plhs, nrhs, prhs); break;
  case 36: _wrap_ibclr(nlhs, plhs, nrhs, prhs); break;
  case 37: _wrap_ibcmd(nlhs, plhs, nrhs, prhs); break;
  case 38: _wrap_ibcmda(nlhs, plhs, nrhs, prhs); break;
  case 39: _wrap_ibconfig(nlhs, plhs, nrhs, prhs); break;
  case 40: _wrap_ibdev(nlhs, plhs, nrhs, prhs); break;
  case 41: _wrap_ibdma(nlhs, plhs, nrhs, prhs); break;
  case 42: _wrap_ibeos(nlhs, plhs, nrhs, prhs); break;
  case 43: _wrap_ibeot(nlhs, plhs, nrhs, prhs); break;
  case 44: _wrap_ibfind(nlhs, plhs, nrhs, prhs); break;
  case 45: _wrap_ibgts(nlhs, plhs, nrhs, prhs); break;
  case 46: _wrap_ibist(nlhs, plhs, nrhs, prhs); break;
  case 47: _wrap_iblines(nlhs, plhs, nrhs, prhs); break;
  case 48: _wrap_ibln(nlhs, plhs, nrhs, prhs); break;
  case 49: _wrap_ibloc(nlhs, plhs, nrhs, prhs); break;
  case 50: _wrap_ibonl(nlhs, plhs, nrhs, prhs); break;
  case 51: _wrap_ibpad(nlhs, plhs, nrhs, prhs); break;
  case 52: _wrap_ibpct(nlhs, plhs, nrhs, prhs); break;
  case 53: _wrap_ibpoke(nlhs, plhs, nrhs, prhs); break;
  case 54: _wrap_ibppc(nlhs, plhs, nrhs, prhs); break;
  case 55: _wrap_ibrd(nlhs, plhs, nrhs, prhs); break;
  case 56: _wrap_ibrda(nlhs, plhs, nrhs, prhs); break;
  case 57: _wrap_ibrdf(nlhs, plhs, nrhs, prhs); break;
  case 58: _wrap_ibrpp(nlhs, plhs, nrhs, prhs); break;
  case 59: _wrap_ibrsc(nlhs, plhs, nrhs, prhs); break;
  case 60: _wrap_ibrsp(nlhs, plhs, nrhs, prhs); break;
  case 61: _wrap_ibrsv(nlhs, plhs, nrhs, prhs); break;
  case 62: _wrap_ibsad(nlhs, plhs, nrhs, prhs); break;
  case 63: _wrap_ibsic(nlhs, plhs, nrhs, prhs); break;
  case 64: _wrap_ibsre(nlhs, plhs, nrhs, prhs); break;
  case 65: _wrap_ibstop(nlhs, plhs, nrhs, prhs); break;
  case 66: _wrap_ibtmo(nlhs, plhs, nrhs, prhs); break;
  case 67: _wrap_ibtrg(nlhs, plhs, nrhs, prhs); break;
  case 68: _wrap_ibwait(nlhs, plhs, nrhs, prhs); break;
  case 69: _wrap_ibwrt(nlhs, plhs, nrhs, prhs); break;
  case 70: _wrap_ibwrta(nlhs, plhs, nrhs, prhs); break;
  case 71: _wrap_ibwrtf(nlhs, plhs, nrhs, prhs); break;
  case 72: _wrap_user_ibcnt(nlhs, plhs, nrhs, prhs); break;
  case 73: _wrap_user_ibcntl(nlhs, plhs, nrhs, prhs); break;
  case 74: _wrap_user_iberr(nlhs, plhs, nrhs, prhs); break;
  case 75: _wrap_user_ibsta(nlhs, plhs, nrhs, prhs); break;

  default: mexErrMsgTxt("Illegal function ID parameter");
  }
}

#ifdef __cplusplus
}
#endif
