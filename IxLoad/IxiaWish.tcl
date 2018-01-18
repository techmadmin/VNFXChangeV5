namespace eval ::ixiaInstall:: {
    # By default tclDir is the directory containing TclScripts/IxiaWish.tcl
    # For debugging, you can point this to an alternate location.  It should
    # point to a directory that contains a the "TclScripts" subdirectory.
    set tclDir [file dirname [file dirname [file dirname [info script]]]]

    # Calls appinfo to add paths to IxOS dependencies (such as IxLoad or IxNetwork).
    proc ixAddPathsFromAppinfo {installdir} {
        package require registry 1.1
        
        foreach {reg_path} [list "HKEY_LOCAL_MACHINE\\SOFTWARE\\Ixia Communications\\AppInfo\\InstallInfo" "HKEY_CURRENT_USER\\SOFTWARE\\Ixia Communications\\AppInfo\\InstallInfo"] {
            if { [ catch {registry get $reg_path "HOMEDIR"} r] == 0 } {
                set appinfo_path $r
                break
            }
        }

        # Call appinfo to get the list of all dependencies:
        regsub -all "\\\\" $appinfo_path "/" appinfo_path      
        set appinfo_executable [file attributes "$appinfo_path\Appinfo.exe" -shortname]
        set appinfo_handle [open "|$appinfo_executable --app-path \"$installdir\" --get-dependencies" r+ ]

        while { [gets $appinfo_handle line] >= 0 } {
            regsub -all "\\\\" $line "/" line
            regexp "^(.+):\ (.*)$" $line all app_name app_path
            if {"" ne $app_path } {
                if { -1 == [lsearch -exact ::auto_path $app_path ] } {
                    lappend auto_path $app_path
                }
            }
        }
    }

    # Adds all needed Ixia paths
    proc ixAddPaths {installdir} {
        lappend ::auto_path [file join ${installdir} TclScripts lib]
        if { [catch {::ixiaInstall::ixAddPathsFromAppinfo $installdir} r] } {
            puts "Unable to add paths from Appinfo"
        }
        append ::env(PATH) ";${installdir}"
    }
    
    proc ixAddPythonPaths {tclDir} {

    if {![info exists ::env(PYTHONPATH)]} {
        set ::env(PYTHONPATH) " "
    }
    if {![info exists ::env(PYTHONHOME)]} {
        set ::env(PYTHONHOME) " "
    }
    set ::env(PYTHONHOME)   ${::ixiaInstall::tclDir}\\3rdParty\\Python2.7
    
    set $::auto_path [linsert $::auto_path 0 ${::ixiaInstall::tclDir}\\TclScripts\\lib\\comm]

    set ::env(PATH)         [format "%s;%s" "${::ixiaInstall::tclDir}\\IxVerify\\bin;${::ixiaInstall::tclDir}\\IxVerify\\bin\\en;" $::env(PATH)]
    set ::env(PATH)         [format "%s;%s" "${::ixiaInstall::tclDir}\\3rdParty\\Python2.7\\DLLs;" $::env(PATH)]
    set ::env(PATH)         [format "%s;%s" "${::ixiaInstall::tclDir}\\3rdParty\\Python2.7;" $::env(PATH)]
    set ::env(PATH)         [format "%s;%s" "${::ixiaInstall::tclDir}\\3rdParty\\Python2.7\\Lib;" $::env(PATH)]
    
    set ::env(PYTHONPATH)   [format "%s;%s" "${::ixiaInstall::tclDir}\\IxVerify\\bin;${::ixiaInstall::tclDir}\\IxVerify\\bin\\en;" $::env(PYTHONPATH)]
    set ::env(PYTHONPATH)   [format "%s;%s" "${::ixiaInstall::tclDir}\\3rdParty\\Python2.7\\DLLs;" $::env(PYTHONPATH)]
    set ::env(PYTHONPATH)   [format "%s;%s" "${::ixiaInstall::tclDir}\\Client;" $::env(PYTHONPATH)]
    set ::env(PYTHONPATH)   [format "%s;%s" "${::ixiaInstall::tclDir}\\3rdParty\\Python2.7;" $::env(PYTHONPATH)]
    
    set ::_PY_SITE_PKGS_DIR "${::ixiaInstall::tclDir}\\3rdParty\\Python2.7\\Lib\\site-packages"
    set ::env(PYTHONPATH)   [format "%s;%s" "${::_PY_SITE_PKGS_DIR};" $::env(PYTHONPATH)]
    set ::env(PYTHONPATH)   [format "%s;%s" "${::_PY_SITE_PKGS_DIR}\\win32;" $::env(PYTHONPATH)]
    set ::env(PATH)         [format "%s;%s" "${::_PY_SITE_PKGS_DIR};" $::env(PATH)]
    set ::env(PYTHONPATH)   [format "%s;%s" "${::_PY_SITE_PKGS_DIR}\\win32\\lib;" $::env(PYTHONPATH)]
    set ::env(PYTHONPATH)   [format "%s;%s" "${::_PY_SITE_PKGS_DIR}\\pythonwin\\lib;" $::env(PYTHONPATH)]
    set ::env(PYTHONPATH)   [format "%s:%s" "${::_PY_SITE_PKGS_DIR}\\pythonwin;" $::env(PYTHONPATH)]
    
    set PyStatEnginePath [ file join $::ixiaInstall::tclDir aptixia bin winVC6 ]
    set ::env(PATH)         [format "%s;%s" $PyStatEnginePath $::env(PATH)]
    set ::env(PYTHONPATH)   [format "%s;%s" $PyStatEnginePath $::env(PYTHONPATH)]
    set ::env(PATH)         [format "%s;%s" "${::ixiaInstall::tclDir};" $::env(PATH)]

    # Aptixia python module location
    set ::env(PYTHONPATH)   [format "%s;%s" "${::ixiaInstall::tclDir}\\aptixia\\bin\\common\\python;" $::env(PYTHONPATH)]
    set ::env(PATH)         [format "%s;%s" "${::ixiaInstall::tclDir}\\aptixia\\bin\\common\\python;" $::env(PATH)]

    # Aptixia
    set ::env(PYTHONPATH)   [format "%s;%s" "${::ixiaInstall::tclDir}\\aptixia\\lib\\common\\pythonclient;" $::env(PYTHONPATH)]
    set ::env(PYTHONPATH)   [format "%s;%s" "${::ixiaInstall::tclDir}\\aptixia\\bin\\win;" $::env(PYTHONPATH)]

    # Path to the protocol plugins
    set ::env(IXWEB_PLUGINS) "${::ixiaInstall::tclDir}\\Client\\Plugins"
    set ::env(PYTHONPATH)   [format "%s;%s" "${::ixiaInstall::tclDir}\\Client\\Plugins\\agent;" $::env(PYTHONPATH)]

    set pluginsDir [glob -directory ${::ixiaInstall::tclDir}\\Client\\Plugins\\agent -type d *]
    
    foreach pluginDir $pluginsDir {
        set ::env(PYTHONPATH)   [format "%s;%s" $pluginDir $::env(PYTHONPATH)]
    }
        
    # pyqt paths
    set ::env(PYTHONPATH)   [format "%s;%s" "${::ixiaInstall::tclDir}\\Client\\Gui\\QtWrapper;" $::env(PYTHONPATH)]
    set ::env(PATH)         [format "%s;%s" "${::ixiaInstall::tclDir}\\3rdParty\\Qt3.3.2\\bin;" $::env(PATH)]

    # for csvUtil.pyd used by agents
    set ::env(PYTHONPATH)   [format "%s;%s" "${::ixiaInstall::tclDir}\\3rdParty\\Misc;" $::env(PYTHONPATH)]

    # Aptixia paths
    set ::env(PATH) [format "%s;%s" "${::ixiaInstall::tclDir}\\aptixia\\bin\\win;" $::env(PATH)]

    # IxView
    set ::env(PATH) [format "%s;%s" "${::ixiaInstall::tclDir}\\aptixia\\bin\\winVC6\\IxView;" $::env(PATH)]
    set ::env(PATH) [format "%s;%s" "${::ixiaInstall::tclDir}\\aptixia\\api\\ixview_sdk;" $::env(PATH)]

    # IxVoice
    set ::env(PATH) [format "%s;%s" "${::ixiaInstall::tclDir}\\IxVoicePlugin;" $::env(PATH)]
    set ::env(PYTHONPATH) [format "%s;%s" "${::ixiaInstall::tclDir}\\IxVoicePlugin;" $::env(PYTHONPATH)]
    # IxVoice(Dev)
    if {[info exists ::env(_IXV_DEBUG)]} {
    set ::env(PATH) [format "%s;%s" "${::ixiaInstall::tclDir}\\aptixia\\bin\\wind\\IxVoicePlugin;" $::env(PATH)]
    set ::env(PYTHONPATH) [format "%s;%s" "${::ixiaInstall::tclDir}\\aptixia\\bin\\wind\\IxVoicePlugin;" $::env(PYTHONPATH)]
    } else {
    set ::env(PATH) [format "%s;%s" "${::ixiaInstall::tclDir}\\aptixia\\bin\\win\\IxVoicePlugin;" $::env(PATH)]
    set ::env(PYTHONPATH) [format "%s;%s" "${::ixiaInstall::tclDir}\\aptixia\\bin\\win\\IxVoicePlugin;" $::env(PYTHONPATH)]
    }

    # These are needed for plugins which need to access dll under client\bin
    set ::env(PYTHONPATH) [format "%s;%s" "${::ixiaInstall::tclDir}\\Client\\bin;" $::env(PYTHONPATH)]
    set ::env(PATH) [format "%s;%s" "${::ixiaInstall::tclDir}\\Client\\bin;" $::env(PATH)]
    }
}

::ixiaInstall::ixAddPaths $::ixiaInstall::tclDir
::ixiaInstall::ixAddPythonPaths $::ixiaInstall::tclDir
catch {
    # Try to set things up for Wish.  
    # This section will not run in IxExplorer or IxTclInterpreter, hence the catch block.
    if {[lsearch [package names] "Tk"] >= 0} {
        console show
        wm iconbitmap . "${::ixiaInstall::tclDir}ixos.ico"
        puts -nonewline "(TclScripts) 1 % "
    }
}












