#!/bin/bash
# chkconfig: 2345 95 05
# description: Fitnesse server daemon

prog=Fitnesse

RETVAL=0

start() {
        echo -n $"Starting $prog: "
        cd /usr/share/fitnesse
        java -cp '/var/lib/fitnesse/dbfit-docs-3.1.0.jar:/var/lib/fitnesse/fitnesse-standalone-20140903.jar' fitnesseMain.FitNesseMain -l /var/log/fitnesse $@
        RETVAL=$?
        echo
        [ $RETVAL = 0 ] && touch /var/lock/subsys/fitnesse
        return $RETVAL
}

stop() {
        echo -n $"Stopping $prog: "
        # killall fitness # alternative command in some os env
        pkill fitnesse
        RETVAL=$?
        echo
        [ $RETVAL = 0 ] && rm -f /var/lock/subsys/fitnesse /var/run/fitnesse/fitnesse.pid

}


# See how we were called.
case "$1" in
  start)
        start
        ;;

  stop)
        stop
        ;;

  *)
        echo $"Usage: $prog {start|stop}"
        exit 1

        exit 1

esac

exit $RETVAL