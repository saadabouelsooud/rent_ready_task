# Rent Ready Technical Assessment (Implemented to run in Android Emulator)

Rent Ready Technical Assessment.

## Getting Started (YOU CAN BUILD IN Android Emulator BY CLONE THIS REPOSITORY THEN OPEN IN ANDROID STUDIO OR VISUAL STUDIO CODE THEN RUN)

OR BUILD & RUN USING DOCKER AS FOLLOW:

Requirements to run in mac os using docker:

    Your computer must have at least 8GB of RAM.
    A Mac or a Windows PC/Laptop.
    A real Android Device.
    Docker Installed.(with Memory setting : 8GB )
    Visual Code installed. Including these plugins: Docker and Remote Development
    SDK Platform-Tools. If you already installed Android Studio, it should be included.
    Android Emulator.
    xhost install and forward it from inside docker in mac os as follow:
      Install XQuartz: https://www.xquartz.org/
      Launch XQuartz. Under the XQuartz menu, select Preferences
      Go to the security tab and ensure "Allow connections from network clients" is checked.
      Run xhost + ${hostname} to allow connections to the macOS host *
      Setup a HOSTNAME env var export HOSTNAME=`hostname`*

 Steps to build in Android Emulator using docker:

      Download flutter_docker(https://drive.google.com/file/d/16iy6Qk3-9jGO734_iuBc3edzgdU9CRxm/view?usp=sharing) and extract it.
      Open Visual Studio Code (With required plugins installed) and make sure Docker is running.
      Open Android Emulator.
      Click the Icon where the red arrow points at and select the option Remote-Containers: Open Folder in Container.
      Select and open the flutter_docker folder.
      Navigate to workspace>rent_ready_task_vsc inside Visual Studio Code and select Open in terminal.
      run the following commands :
          adb tcpip 5555
          adb connect host.docker.internal:5555
          adb devices
      In the previous step, you might get device unauthorized. To fix that, run:
          adb kill-server
          In your docker container connect to device:  adb connect host.docker.internal:5555
          adb devices
     Now you will see that the unauthorized error is gone.
     Run flutter doctor once to verify that the device is recognized by Flutter.
     Run command flutter run to finally build the app in your emulator.


