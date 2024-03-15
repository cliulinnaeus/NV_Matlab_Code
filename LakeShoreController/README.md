# MATLAB&reg; GUI for Lake Shore&reg; Cryogenic Temperature Controller

Developed by *Yuanqi Lyu* ([yuanqilyu@berkeley.edu](mailto:yuanqilyu@berkeley.edu)) at UC Berkeley.

This is a simple GUI for Lake Shore temperature (heater) controllers using serial connection.

### Compatibility
* Tested on MATLAB&reg; 2020b.
* Tested on [Lake Shore&reg; Model 336 Cryogenic Temperature Controller](https://www.lakeshore.com/products/categories/overview/temperature-products/cryogenic-temperature-controllers/model-336-cryogenic-temperature-controller); should also work for other Lake Shore&reg; cryogenic temperature controllers with similar serial interface commands.

### Usage
* Edit `Config.txt` to match that of your hardware configuration, use `tab` to seperate columes. The `N_Heater` and `N_TempSensor` fields are numbers of heater outputs and temperature sensor inputs connected to your controller. In terms of Lake Shore 336, there could be maxima of 2 heaters and 4 temperature sensors. The `Temp_LimLower` and `Temp_LimLower` fileds are lower and upper bonds of your setup's working temperature range (in Kelvin).
    
        SerialPort_Name	COM5
        N_Heater	2
        N_TempSensor	2
        Log_Path	Data
        Temp_LimLower	0
        Temp_LimUpper	370
* In MATLAB&reg; command window, run command:
        
        CtrlGUI_LS336
* In GUI, input correct serial port name (e.g. "COM1") and start the connection by turn on the switch.
