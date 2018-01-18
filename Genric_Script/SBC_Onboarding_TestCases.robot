*** Settings ***
Resource          Genric_Keywords.robot
Resource          Genric_Variable.robot
Resource          Oracle_SBC_Keywords.txt
Library           SSHLibrary
Library           Selenium2Library
Library           ImageHorizonLibrary
Library           String
Library           Collections
Library           Process
Library           Python_Script/Library.py

*** Test Cases ***
TC1_Verification of on-boarded vnf on RHOSP
    [Documentation]    Verify the Cloud environment (RHOSP) before we start Onboarding of VNF VM’s process.
    [Tags]    Onboard
    @{Server}    ImportDetails    ${CURDIR}\\Config\\Enterprise_Config.txt    ${Label}
    Set Global Variable    @{Server}
    ${Index}    Server_Login    @{Server}
    Print Logger    Server Logged
    SBC_CreateFlavor    #This Keyword creates Flavor on Openstack
    Flavor_Validation    #This Keyword Perform the validation of Flavor Created above
    SBC_CreateImage    #This Keyword Upload the image from local machine to Controller and create Image on Openstack
    Image_Validation    #This Keyword Perform the validation of Image Created above
    SBC_OnboardVM    #This Keyword \ create Intance on Openstack ,which use the flavor and Image Created above.
    Onboard_Validation    ${Index}    #This Keyword Perform the validation of Instance Created above
    Print Logger    *******Onboard_Validation Done*******
    AvailabilityZone_Validation    #This Keyword Perform the validation of Instance Created on Which Compute
    Print Logger    *******AvailabilityZone_Validation Done*******
    Networks_Validation
    Print Logger    *******Networks_Validation Done*******
    Print Logger    *******SBC Configuration In Progress*******
    SBC Configuration    #This Keyword do the port updation,password update,setup entitlements ,Configuration.
    Print Logger    *******SBC Configuration Done*******
    [Teardown]    Close All Connections

TC2_Verify able to login/logout into vSBC
    [Tags]
    @{Server}    ImportDetails    ${CURDIR}\\Config\\Enterprise_Config.txt    ${Label}
    Server_Login    @{Server}
    write    nova list | grep -i ${VNFName}| awk -F ";" '{print $2}' | awk -F "=" '{print $2}'| awk -F " \ " '{print $1}'    #get IP of SBC
    sleep    10
    ${Output}    read
    @{Output}    Split String    ${Output}
    ${SBC_Mgmt_IP}    Get From List    ${Output}    0
    log    **************** Configuration Start ************
    # phy-interface
    sleep    5
    Write    ssh -o "StrictHostKeyChecking no" user@${SBC_Mgmt_IP}
    sleep    5
    Comment    ${Output}    Read
    write    ${SBC_NewPassword}
    sleep    3
    ${Output}    read
    Should Contain    ${Output}    SBC>
    log    login to vsbc successful******
    write    exit
    SLEEP    2
    ${Output}    read
    Should Contain    ${Output}    [root@controller ~(keystone_admin)]#
    Log    Logout from vSBC Successful****
    [Teardown]    Close All Connections

TC3_Verify ping from all network interfaces of vSBC
    [Tags]
    @{Server}    ImportDetails    ${CURDIR}\\Config\\Enterprise_Config.txt    ${Label}
    Server_Login    @{Server}
    write    nova list | grep -i ${VNFName}| awk -F ";" '{print $2}' | awk -F "=" '{print $2}'| awk -F " \ " '{print $1}'    #get IP of SBC
    sleep    10
    ${Output}    read
    @{Output}    Split String    ${Output}
    ${SBC_Mgmt_IP}    Get From List    ${Output}    0
    log    **************** Configuration Start ************
    # phy-interface
    sleep    5
    Write    ssh -o "StrictHostKeyChecking no" user@${SBC_Mgmt_IP}
    sleep    5
    Comment    ${output}=    Read
    write    ${SBC_NewPassword}
    sleep    2
    write    en
    sleep    1
    write    ${SBC_NewPassword}
    Comment    ${output}=    Read
    sleep    2
    Comment    Write    ifconfig -a    #this command is not working properly
    Comment    ${output}    read
    ${HOST}    Get From List    ${Server}    0
    ${store}    catenate    ping    ${HOST}
    Write    ${store}
    sleep    10
    ${output}    read
    Should Contain    ${output}    time
    log    pinging successful for controller****
    ${store}    catenate    ping    ${DEFAULT-GATEWAY}
    Write    ${store}
    sleep    10
    ${output}    read
    Should Contain    ${output}    time
    log    pinging successful for default gateway****​
    [Teardown]    Close All Connections

TC4_Accesing SBC Platform
    [Tags]
    @{Server}    ImportDetails    ${CURDIR}\\Config\\Enterprise_Config.txt    ${Label}
    Server_Login    @{Server}
    Comment    Login    ${SBC USERNAME}    ${SBC NEW PASSWORD}
    write    nova list | grep -i ${VNFName}| awk -F ";" '{print $2}' | awk -F "=" '{print $2}'| awk -F " \ " '{print $1}'    #get IP of SBC
    sleep    10
    ${Output}    read
    @{Output}    Split String    ${Output}
    ${SBC_Mgmt_IP}    Get From List    ${Output}    0
    Open Connection    ${SBC_Mgmt_IP}
    Login    ${SBC_Username}    ${SBC NEW PASSWORD}
    Write    en
    sleep    2
    write    ${SBC NEW PASSWORD}
    Write    configure terminal
    sleep    3
    ${output}    Read
    Should Contain    ${output}    (configure)#
    sleep    2
    write    exit
    ${output}    read

Offboard the Vnf on RHOSP
    [Tags]    offboard
    @{Server}    ImportDetails    ${CURDIR}\\Config\\Enterprise_Config.txt    ${Label}
    Server_Login    @{Server}
    write    nova flavor-delete ${FlavourName}    #Remove Flavor
    sleep    4
    write    nova image-delete ${ImageName}    #Remove Image
    sleep    4
    write    nova delete ${VNFName}    # Remove Instance
    sleep    4
    read
