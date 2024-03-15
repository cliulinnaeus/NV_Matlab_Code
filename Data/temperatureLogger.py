# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import nidaqmx
import datetime as dt
import matplotlib
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import numpy as np
#import tmp102

#with nidaqmx.Task() as task:
#    task.ai_channels.add_ai_voltage_chan("Dev1/ai0")
#    print(task.read(number_of_samples_per_channel=20))
    

# Create figure for plotting
fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
global xs, ys
xs = np.array([])
ys = np.array([])

times = 'TempLog_times' + dt.datetime.now().strftime('%Y-%m-%d_%H%M') + '.npy'
volts = 'TempLog_volts' + dt.datetime.now().strftime('%Y-%m-%d_%H%M') + '.npy'
datalog = 'TempLog' + dt.datetime.now().strftime('%Y-%m-%d') + '.txt'



def mySaver(filename, xs, ys):
    dat = np.array([xs, ys])
    print(dat)
    f=open(filename,'ab')
    np.save(f, dat)
    f.close()
    return

def vol2tem(vol):            
    A = 1.1235e-3
    B = 2.35e-4
    C = 8.4538e-8
    R = 10000 * vol
    tem = 1/(A + B * np.log(R) + C * (np.log(R))**3) - 273.15
    return tem
    

# This function is called periodically from FuncAnimation
def animate(i):
    global xs, ys
    
    with nidaqmx.Task() as task:
        task.ai_channels.add_ai_voltage_chan("Dev1/ai1, Dev1/ai2")  # Modify here to readout two channels
        temp_c = vol2tem(np.array(task.read(number_of_samples_per_channel=1)))
    time = dt.datetime.now();    
    
    if i%100==0:
        f=open(volts,'wb')
        np.save(f, ys)
        f.close()
        
        f=open(times,'wb')
        np.save(f, xs)
        f.close()
        
    writestr = str(time.strftime('%d-%b-%Y %H:%M:%S')) + " "
    for i in range(len(temp_c)):
        writestr += (str(round(temp_c[i][0], 3)) + " ")
    writestr += "\n"
    
    f = open(datalog, 'a')
    f.writelines(writestr)
    f.close()
    
    # Add x and y to lists   
    xs = np.append(xs, time)  #strftime('%H:%M:%S.%f'))
    ys = np.append(ys, temp_c)


    # Limit x and y lists to 100 items
    n = 2 # number of channels
    xs = xs[-1200:]
    ys = ys[-1200 * n:]
    

    # Draw x and y lists
    ax.clear()
    for i in range(n):
        ax.plot(xs, ys[i:len(ys):n])


    # Format plot
    plt.xticks(rotation=45, ha='right')
    plt.subplots_adjust(bottom=0.30)
    plt.title('Thermistor Voltage over Time')
    plt.ylabel('Voltage (V)')

# Set up plot to call animate() function periodically
ani = animation.FuncAnimation(fig, animate, interval=10000)  
plt.show()
