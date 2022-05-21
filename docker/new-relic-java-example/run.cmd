javac Main.java
jar cvf Main.jar Main.class
@REM java -cp Main.jar Main


set NEW_RELIC_APP_NAME="TESTE"
set NEW_RELIC_LICENSE_KEY="356e8c09c6e4ad07ca0f0021bb847b82c374NRAL"

java ^
  -javaagent:newrelic/newrelic.jar ^
  -cp Main.jar Main