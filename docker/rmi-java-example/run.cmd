javac Main.java
jar cvf Main.jar Main.class
@REM java -cp Main.jar Main


java ^
 -Dcom.sun.management.jmxremote=true ^
  -Dcom.sun.management.jmxremote.local.only=false ^
  -Dcom.sun.management.jmxremote.authenticate=false ^
  -Dcom.sun.management.jmxremote.ssl=false ^
  -Djava.rmi.server.hostname=localhost ^
  -Dcom.sun.management.jmxremote.port=9010 ^
  -Dcom.sun.management.jmxremote.rmi.port=9010 ^
  -cp Main.jar Main