# Notes on DBus


https://stackoverflow.com/questions/31415665/using-gdbus-to-start-a-systemd-service




https://gist.github.com/gaurav36/7e1e78f13c6fc5e5921e6b2a330346ff



Note that this instance has a `ubuntu` user that is used to for gdbus. updates, etc (since when??)

sudo gdbus call --system --dest org.freedesktop.systemd1 --object-path /org/freedesktop/systemd1 --method org.freedesktop.systemd1.Manager.StartUnit demo.service replace



gdbus call --system --dest org.freedesktop.systemd1 --object-path /org/freedesktop/systemd1 --method org.freedesktop.systemd1.Manager.StopUnit demo.service replace


import sys
import dbus

bus = dbus.SystemBus()
systemd = bus.get_object('org.freedesktop.systemd1', '/org/freedesktop/systemd1')
manager = dbus.Interface(systemd, 'org.freedesktop.systemd1.Manager')

def disable_and_stop(service):
    """
    disable_and_stop and stop method will check if the service is already running or not in system.
  	If its already running then it will first stop the service. After that it will check if service
	  is already enabled or not. If its enabled then it will disabled the service.
    It raise exception if there is error

    :param str service: name of the service
    """
    if is_service_active(service):
        try:
            manager.StopUnit(service, 'replace')
        except:
            sys.exit("Error: Failed to stop {}.".format(service))

    if is_service_enabled(service):
        try:
            manager.DisableUnitFiles([service], False)
        except:
            sys.exit("Error: Failed to disable {}.".format(service))


def enable(service):
    """
    enable method will enable service that is passed in this method.
	  It raise exception if there is error

    :param str service: name of the service
    """
    try:
        manager.EnableUnitFiles([service], False, True)
    except:
        sys.exit("Error: Failed to enable {}.".format(service))


def start(service):
    """
    start method will start service that is passed in this method.
	  If service is already started then it will ignore it.
	  It raise exception if there is error

    :param str service: name of the service
    """
    try:
       manager.StartUnit(service, 'replace')
    except:
       sys.exit("Error: Failed to start {}.".format(service))


def restart(service):
   """
   restart method will restart service that is passed in this method.
   It raise exception if there is error

   :param str service: name of the service
   """
   try:
       manager.RestartUnit(service, 'replace')
   except:
       sys.exit("Error: Failed to restart {}.".format(service))


def is_service_enabled(service):
   """
   is_service_enabled method will check if service is already enabled that
   is passed in this method.
   It raise exception if there is error.
   Return value, True if service is already enabled otherwise False.

   :param str service: name of the service
   """
    try:
        return manager.GetUnitFileState(service) == 'enabled'
    except:
        return False


def is_service_active(service):
   """
   is_service_active method will check if service is running or not.
   It raise exception if there is service is not loaded
   Return value, True if service is running otherwise False.
   :param str service: name of the service
   """
    try:
        manager.GetUnit(service)
        return True
    except:
        return False


def enable_and_start(service):
   """
   enable_and_start method will enable and start service.
   Return value, True if service is running otherwise False.
   :param str service: name of the service
   """
    try:
        if not is_service_enabled(service):
            enable(service)

		    if not is_service_active(service):
			      start(service)

        return True

    except:
        return False
