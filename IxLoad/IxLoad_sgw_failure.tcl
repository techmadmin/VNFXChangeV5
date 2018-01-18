#################################################
# IxLoad ScriptGen created script
# Test1 serialized using version 8.10.0.300
# IxLoad_sgw_failure.tcl made on Jan 16 2018 18:25
#################################################


#################################################
# Copy content of setup_ixload_paths.tcl
#################################################
source 	"C:\\Program Files (x86)\\Ixia\\IxLoad\\8.10-EA\\TclScripts\\Samples\\setup_ixload_paths_new.tcl"
package require IxLoad

::IxLoad connect 1.2.3.4

if [catch {

set logtag "IxLoad-api"
set logName "IxLoad_sgw_failure"
set logger [::IxLoad new ixLogger $logtag 1]
set logEngine [$logger getEngine]
$logEngine setLevels $::ixLogger(kLevelDebug) $::ixLogger(kLevelInfo)
$logEngine setFile $logName 2 256 1

global ixAppPluginManager
$ixAppPluginManager load "HTTP"

#################################################
# Build chassis chain
#################################################
set chassisChain [::IxLoad new ixChassisChain]

$chassisChain addChassis 192.168.31.42

set Test1 [::IxLoad new ixTest]

set scenarioElementFactory [$Test1 getScenarioElementFactory]

set scenarioFactory [$Test1 getScenarioFactory]

#################################################
# Profile Directory
#################################################
set profileDirectory [$Test1 cget -profileDirectory]

set my_ixEventHandlerSettings [::IxLoad new ixEventHandlerSettings]

$my_ixEventHandlerSettings config \
	-disabledEventClasses                    "" \
	-disabledPorts                           "" 

set my_ixViewOptions [::IxLoad new ixViewOptions]

$my_ixViewOptions config \
	-runMode                                 1 \
	-captureRunDuration                      0 \
	-captureRunAfter                         0 \
	-collectScheme                           0 \
	-allocatedBufferMemoryPercentage         30 

$Test1 scenarioList.clear

set TrafficFlow1 [$scenarioFactory create "Scenario"]

$TrafficFlow1 columnList.clear

set Originate [::IxLoad new ixTrafficColumn]

$Originate elementList.clear

#################################################
# Create ScenarioElement kNetTraffic
#################################################
set Traffic1_Network1 [$scenarioElementFactory create $::ixScenarioElementType(kNetTraffic)]



#################################################
# Network Network1 of NetTraffic Traffic1@Network1
#################################################
set Network1 [$Traffic1_Network1 cget -network]

$Network1 portList.appendItem \
	-chassisId                               1 \
	-cardId                                  1 \
	-portId                                  2 

$Network1 portList(0).setPortCaptureEnable true

$Network1 portList(0).setPortCaptureFileName "RESULTS\\IxLoad_sgw_failure\\Port_1_1_2_capture.cap"

$Network1 globalPlugins.clear



set Settings_1 [::IxLoad new ixNetIxLoadSettingsPlugin]

# ixNet objects need to be added in the list before they are configured!
$Network1 globalPlugins.appendItem -object $Settings_1



$Settings_1 config \
	-teardownInterfaceWithUser               true \
	-_Stale                                  false \
	-interfaceBehavior                       1 

set Filter_1 [::IxLoad new ixNetFilterPlugin]

# ixNet objects need to be added in the list before they are configured!
$Network1 globalPlugins.appendItem -object $Filter_1



$Filter_1 config \
	-all                                     false \
	-pppoecontrol                            false \
	-isis                                    false \
	-auto                                    true \
	-udp                                     "" \
	-tcp                                     "" \
	-mac                                     "" \
	-_Stale                                  false \
	-pppoenetwork                            false \
	-ip                                      "" \
	-icmp                                    "" 

set GratARP_1 [::IxLoad new ixNetGratArpPlugin]

# ixNet objects need to be added in the list before they are configured!
$Network1 globalPlugins.appendItem -object $GratARP_1



$GratARP_1 config \
	-forwardGratArp                          false \
	-enabled                                 true \
	-maxFramesPerSecond                      0 \
	-_Stale                                  false \
	-rateControlEnabled                      false 

set TCP_1 [::IxLoad new ixNetTCPPlugin]

# ixNet objects need to be added in the list before they are configured!
$Network1 globalPlugins.appendItem -object $TCP_1



$TCP_1 config \
	-tcp_bic                                 0 \
	-tcp_tw_recycle                          true \
	-tcp_retries2                            5 \
	-disable_min_max_buffer_size             true \
	-tcp_retries1                            3 \
	-tcp_keepalive_time                      7200 \
	-tcp_mgmt_rmem                           87380 \
	-tcp_rfc1337                             false \
	-tcp_ipfrag_time                         30 \
	-tcp_rto_max                             120000 \
	-tcp_window_scaling                      false \
	-adjust_tcp_buffers                      true \
	-udp_port_randomization                  false \
	-tcp_vegas_alpha                         2 \
	-tcp_vegas_beta                          6 \
	-tcp_wmem_max                            262144 \
	-tcp_ecn                                 false \
	-tcp_westwood                            0 \
	-tcp_rto_min                             200 \
	-delayed_acks_segments                   0 \
	-tcp_vegas_cong_avoid                    0 \
	-tcp_keepalive_intvl                     75 \
	-tcp_rmem_max                            262144 \
	-tcp_orphan_retries                      0 \
	-bestPerfSettings                        false \
	-tcp_max_tw_buckets                      180000 \
	-_Stale                                  false \
	-tcp_low_latency                         0 \
	-tcp_rmem_min                            4096 \
	-accept_ra_all                           false \
	-tcp_adv_win_scale                       2 \
	-tcp_wmem_default                        4096 \
	-tcp_wmem_min                            4096 \
	-tcp_port_min                            1024 \
	-tcp_stdurg                              false \
	-tcp_port_max                            65535 \
	-tcp_fin_timeout                         60 \
	-tcp_no_metrics_save                     false \
	-tcp_dsack                               true \
	-tcp_mgmt_wmem                           32768 \
	-tcp_abort_on_overflow                   false \
	-tcp_frto                                0 \
	-tcp_mem_pressure                        32768 \
	-tcp_app_win                             31 \
	-ip_no_pmtu_disc                         true \
	-llm_hdr_gap                             8 \
	-tcp_max_orphans                         8192 \
	-accept_ra_default                       false \
	-tcp_syn_retries                         5 \
	-tcp_moderate_rcvbuf                     0 \
	-tcp_max_syn_backlog                     1024 \
	-tcp_mem_low                             24576 \
	-tcp_tw_rfc1323_strict                   false \
	-tcp_fack                                true \
	-tcp_retrans_collapse                    true \
	-inter_packet_granular_delay             0.0 \
	-llm_hdr_gap_ns                          10 \
	-tcp_large_icwnd                         0 \
	-tcp_rmem_default                        4096 \
	-tcp_keepalive_probes                    9 \
	-tcp_mem_high                            49152 \
	-tcp_tw_reuse                            false \
	-delayed_acks_timeout                    0 \
	-tcp_vegas_gamma                         2 \
	-delayed_acks                            true \
	-tcp_synack_retries                      5 \
	-tcp_timestamps                          true \
	-tcp_reordering                          3 \
	-rps_needed                              false \
	-tcp_sack                                true \
	-tcp_bic_fast_convergence                1 \
	-tcp_bic_low_window                      14 

set DNS_1 [::IxLoad new ixNetDnsPlugin]

# ixNet objects need to be added in the list before they are configured!
$Network1 globalPlugins.appendItem -object $DNS_1



$DNS_1 hostList.clear



$DNS_1 searchList.clear



$DNS_1 nameServerList.clear



$DNS_1 config \
	-domain                                  "" \
	-_Stale                                  false \
	-timeout                                 30 

set Meshing_1 [::IxLoad new ixNetMeshingPlugin]

# ixNet objects need to be added in the list before they are configured!
$Network1 globalPlugins.appendItem -object $Meshing_1



$Meshing_1 trafficMaps.clear



set HTTPClient1_Traffic2_HTTPServer1 [::IxLoad new ixNetMeshingTrafficMap]

# ixNet objects need to be added in the list before they are configured!
$Meshing_1 trafficMaps.appendItem -object $HTTPClient1_Traffic2_HTTPServer1



$HTTPClient1_Traffic2_HTTPServer1 config \
	-ipPreference                            2 \
	-name                                    "HTTPClient1!Traffic2_HTTPServer1" \
	-portRangesString                        "" \
	-destinationActivityId                   0 \
	-_Stale                                  false \
	-meshingType                             2 \
	-sourceActivityId                        0 \
	-configMapFilename                       "HTTPClient1Script.configmap" 

$Meshing_1 config -_Stale false

$Network1 config \
	-comment                                 "" \
	-name                                    "Network1" \
	-lineSpeed                               "Default" \
	-aggregation                             0 

set Ethernet_1 [$Network1 getL1Plugin]



set my_ixNetDataCenterSettings [::IxLoad new ixNetDataCenterSettings]

$my_ixNetDataCenterSettings dcPfcMapping.clear



$my_ixNetDataCenterSettings config \
	-dcSupported                             true \
	-dcEnabled                               false \
	-dcPfcPauseDelay                         1 \
	-_Stale                                  false \
	-dcMode                                  2 \
	-dcPfcPauseEnable                        false \
	-dcFlowControl                           0 

set my_ixNetEthernetELMPlugin [::IxLoad new ixNetEthernetELMPlugin]

$my_ixNetEthernetELMPlugin config \
	-negotiationType                         "master" \
	-_Stale                                  false \
	-negotiateMasterSlave                    true 

set my_ixNetDualPhyPlugin [::IxLoad new ixNetDualPhyPlugin]

$my_ixNetDualPhyPlugin config \
	-medium                                  "copper" \
	-_Stale                                  false 

$Ethernet_1 childrenList.clear



set MAC_ENB [::IxLoad new ixNetL2EthernetPlugin]

# ixNet objects need to be added in the list before they are configured!
$Ethernet_1 childrenList.appendItem -object $MAC_ENB



$MAC_ENB childrenList.clear



set IP_ENB [::IxLoad new ixNetIpV4V6Plugin]

# ixNet objects need to be added in the list before they are configured!
$MAC_ENB childrenList.appendItem -object $IP_ENB



$IP_ENB childrenList.clear



set ENB [::IxLoad new ixNetEGTPPlugin]

# ixNet objects need to be added in the list before they are configured!
$IP_ENB childrenList.appendItem -object $ENB



set MAC_MME [::IxLoad new ixNetL2EthernetPlugin]

$MAC_MME childrenList.clear



set IP_MME [::IxLoad new ixNetDualStackIPPlugin]

# ixNet objects need to be added in the list before they are configured!
$MAC_MME childrenList.appendItem -object $IP_MME



$IP_MME childrenList.clear



set SM_DNS_1 [::IxLoad new ixNetSM_DNSPlugin]

# ixNet objects need to be added in the list before they are configured!
$IP_MME childrenList.appendItem -object $SM_DNS_1



$SM_DNS_1 childrenList.clear



$SM_DNS_1 extensionList.clear



$SM_DNS_1 config -_Stale false

$IP_MME rangeGroups.clear



$IP_MME extensionList.clear



$IP_MME config -_Stale false

$MAC_MME extensionList.clear



$MAC_MME config -_Stale false

set my_ixNetEGTPNetworkActivitySettings [::IxLoad new ixNetEGTPNetworkActivitySettings]

$my_ixNetEGTPNetworkActivitySettings config \
	-implicitSynchronization                 true \
	-_Stale                                  false 

set my_ixNetEGTPNetworkActivity [::IxLoad new ixNetEGTPNetworkActivity]

$my_ixNetEGTPNetworkActivity config \
	-_Stale                                  false \
	-activitySettings                        $my_ixNetEGTPNetworkActivitySettings 

$ENB sgwPoolList.clear



set SGWPool_1 [::IxLoad new ixNetEGTPSGWPool]

# ixNet objects need to be added in the list before they are configured!
$ENB sgwPoolList.appendItem -object $SGWPool_1



$SGWPool_1 config \
	-sgwIpCount                              1 \
	-enabled                                 true \
	-sgwIpType                               "IPv4" \
	-_Stale                                  false \
	-sgwIpv6                                 "::20.0.0.1" \
	-sgwIpv4                                 "50.10.10.12" 

$ENB childrenList.clear



$ENB extensionList.clear



set SM_DCPProxy_1 [::IxLoad new ixNetSM_DCPProxyPlugin]

# ixNet objects need to be added in the list before they are configured!
$ENB extensionList.appendItem -object $SM_DCPProxy_1



$SM_DCPProxy_1 config -_Stale false

$ENB config \
	-version                                 1 \
	-_Stale                                  false \
	-macPluginForMME                         $MAC_MME \
	-networkActivity                         $my_ixNetEGTPNetworkActivity 

$IP_ENB extensionList.clear



$IP_ENB config -_Stale false

$MAC_ENB extensionList.clear



$MAC_ENB config -_Stale false

$Ethernet_1 extensionList.clear



$Ethernet_1 config \
	-advertise10Full                         true \
	-directedAddress                         "01:80:C2:00:00:01" \
	-autoNegotiate                           true \
	-advertise100Half                        true \
	-advertise10Half                         true \
	-enableFlowControl                       false \
	-_Stale                                  false \
	-speed                                   "k100FD" \
	-advertise1000Full                       true \
	-advertise100Full                        true \
	-dataCenter                              $my_ixNetDataCenterSettings \
	-cardElm                                 $my_ixNetEthernetELMPlugin \
	-cardDualPhy                             $my_ixNetDualPhyPlugin 

#################################################
# Setting the ranges starting with the plugins that need to be script gen first
#################################################
$ENB mmeRangeList.clear

set MME_R2 [::IxLoad new ixNetEGTPMMERange]

# ixNet objects need to be added in the list before they are configured.
$ENB mmeRangeList.appendItem -object $MME_R2



$MME_R2 sgwPoolList.clear



set my_ixNetEGTPSGWPoolEntry [::IxLoad new ixNetEGTPSGWPoolEntry]

# ixNet objects need to be added in the list before they are configured!
$MME_R2 sgwPoolList.appendItem -object $my_ixNetEGTPSGWPoolEntry



$my_ixNetEGTPSGWPoolEntry config \
	-_Stale                                  false \
	-nextSGWPool                             $SGWPool_1 

$MME_R2 config \
	-modifyBearerCommandT3                   3 \
	-setMABR                                 false \
	-echoRequestT3                           3 \
	-createIndirectT3                        3 \
	-enableMsgHistory                        false \
	-bearerResourceCommandT3                 3 \
	-deleteBearerCommandT3                   3 \
	-setPRN                                  false \
	-createIndirectN3                        5 \
	-enableSgwDistribution                   false \
	-echoRequestN3                           5 \
	-setNTSR                                 false \
	-srcUdpPort                              2123 \
	-_Stale                                  false \
	-enableEchoRequest                       false \
	-deleteIndirectT3                        3 \
	-bearerResourceCommandN3                 5 \
	-enableForcedChangeReporting             false \
	-enabled                                 true \
	-createSessiontT3                        3 \
	-releaseBearersN3                        5 \
	-deleteBearerCommandN3                   5 \
	-releaseBearersT3                        3 \
	-useBackwardsCompatibleSgwDistribution   true \
	-ratType                                 "6" \
	-modifyBearerN3                          5 \
	-modifyBearerCommandN3                   5 \
	-createSessionN3                         5 \
	-enableChangeReporting                   false \
	-deleteSessionN3                         5 \
	-modifyBearerT3                          3 \
	-sgwCount                                0 \
	-deleteIndirectN3                        5 \
	-deleteSessionT3                         3 \
	-sgwIp                                   "0.0.0.0" 

set DNS_R1 [$MME_R2 getLowerRelatedRange "SM_DNSRange"]

$DNS_R1 config \
	-useAdditionalRecords                    true \
	-ednsReceiveBufferSize                   1280 \
	-useTcp                                  false \
	-cacheReplies                            false \
	-enabled                                 true \
	-serverIp                                "192.168.0.1" \
	-useEdns                                 false \
	-isClassicNaptr                          true \
	-_Stale                                  false \
	-resolveDns                              false \
	-optimizeTcp                             true 

set IP_R5 [$DNS_R1 getLowerRelatedRange "DualStackIPRange"]

$IP_R5 config \
	-prefixV6                                112 \
	-prefixV4                                24 \
	-autoCountEnabled                        false \
	-autoMacGeneration                       true \
	-publishStats                            false \
	-incrementByV6                           "::1" \
	-incrementByV4                           "0.0.0.1" \
	-gatewayAddressV4                        "172.32.2.254" \
	-ipAddressV6                             "::1616:18D2" \
	-mss                                     1460 \
	-randomizeAddress                        false \
	-_Stale                                  false \
	-generateStatistics                      false \
	-enableGatewayArp                        false \
	-gatewayIncrementV4                      "0.0.0.0" \
	-gatewayIncrementV6                      "0::0" \
	-ipAddressV4                             "172.32.2.10" \
	-ipType                                  "IPv4" \
	-count                                   2 \
	-gatewayAddressV6                        "0::0" \
	-enabled                                 true \
	-gatewayIncrementModeV4                  "perSubnet" \
	-gatewayIncrementModeV6                  "perSubnet" \
	-randomizeSeed                           693843797 

set MAC_R3 [$IP_R5 getLowerRelatedRange "MacRange"]

$MAC_R3 config \
	-count                                   2 \
	-enabled                                 true \
	-mtu                                     1500 \
	-mac                                     "00:AC:20:02:0A:00" \
	-_Stale                                  false \
	-incrementBy                             "00:00:00:00:00:01" 

set VLAN_R5 [$IP_R5 getLowerRelatedRange "VlanIdRange"]

$VLAN_R5 config \
	-incrementStep                           1 \
	-innerIncrement                          1 \
	-uniqueCount                             4094 \
	-firstId                                 200 \
	-tpid                                    "0x8100" \
	-idIncrMode                              2 \
	-enabled                                 true \
	-innerFirstId                            1 \
	-innerIncrementStep                      1 \
	-priority                                1 \
	-_Stale                                  false \
	-increment                               1 \
	-innerTpid                               "0x8100" \
	-innerUniqueCount                        4094 \
	-innerEnable                             false \
	-innerPriority                           1 

$ENB eNodeBRangeList.clear

set eNB_R2 [::IxLoad new ixNetEGTPNBRange]

# ixNet objects need to be added in the list before they are configured.
$ENB eNodeBRangeList.appendItem -object $eNB_R2



$eNB_R2 config \
	-rAIMNC3                                 1 \
	-rAIMNC2                                 1 \
	-cI                                      "1" \
	-rAIMCC3                                 1 \
	-tZ                                      "1" \
	-rAC                                     "FF" \
	-rAIRAC                                  "56" \
	-sAC                                     "1011" \
	-mCC                                     "111" \
	-dST                                     0 \
	-rAIMCC1                                 1 \
	-enabled                                 true \
	-rAIMNC1                                 1 \
	-eCI                                     "1" \
	-lAC                                     "FFFE" \
	-_Stale                                  false \
	-rAILAC                                  "1234" \
	-tAC                                     "1011" \
	-rAIMCC2                                 1 \
	-mNC                                     "111" \
	-enbID                                   0 \
	-parentMme                               $MME_R2 

set IP_R1 [$eNB_R2 getLowerRelatedRange "IpV4V6Range"]

$IP_R1 config \
	-count                                   1 \
	-enableGatewayArp                        false \
	-randomizeSeed                           1253054575 \
	-generateStatistics                      false \
	-autoIpTypeEnabled                       false \
	-autoCountEnabled                        false \
	-enabled                                 true \
	-autoMacGeneration                       true \
	-publishStats                            false \
	-incrementBy                             "0.0.0.1" \
	-prefix                                  24 \
	-_Stale                                  false \
	-gatewayIncrement                        "0.0.0.0" \
	-gatewayIncrementMode                    "perSubnet" \
	-mss                                     1460 \
	-randomizeAddress                        false \
	-gatewayAddress                          "172.32.2.254" \
	-ipAddress                               "172.32.2.5" \
	-ipType                                  "IPv4" 

set MAC_R1 [$IP_R1 getLowerRelatedRange "MacRange"]

$MAC_R1 config \
	-count                                   1 \
	-enabled                                 true \
	-mtu                                     1500 \
	-mac                                     "00:AC:20:02:05:00" \
	-_Stale                                  false \
	-incrementBy                             "00:00:00:00:00:01" 

set VLAN_R1 [$IP_R1 getLowerRelatedRange "VlanIdRange"]

$VLAN_R1 config \
	-incrementStep                           1 \
	-innerIncrement                          1 \
	-uniqueCount                             4094 \
	-firstId                                 200 \
	-tpid                                    "0x8100" \
	-idIncrMode                              2 \
	-enabled                                 true \
	-innerFirstId                            1 \
	-innerIncrementStep                      1 \
	-priority                                1 \
	-_Stale                                  false \
	-increment                               1 \
	-innerTpid                               "0x8100" \
	-innerUniqueCount                        4094 \
	-innerEnable                             false \
	-innerPriority                           1 

$ENB ueRangeList.clear

set UE_R2 [::IxLoad new ixNetEGTPUERange]

# ixNet objects need to be added in the list before they are configured.
$ENB ueRangeList.appendItem -object $UE_R2



$UE_R2 mobilityPathList.clear



$UE_R2 ueAuthenticationList.clear



$UE_R2 pgwRangeList.clear



$UE_R2 config \
	-ignoreImei                              false \
	-restriction                             1 \
	-updateAmbrIncrement                     10 \
	-identityCycling                         false \
	-ambrUL                                  1 \
	-displayedIMEI                           "99990000000001" \
	-publishStats                            false \
	-apn                                     "" \
	-aPNIncrement                            false \
	-enableAuth                              false \
	-maxIntervalVariation                    0 \
	-lifetime                                100 \
	-updateAmbrTimeout                       10 \
	-randomizeIMEI                           false \
	-tacListFile                             "Click to set..." \
	-hNI                                     "311180" \
	-mss                                     1424 \
	-incrementBy                             1 \
	-_Stale                                  false \
	-pgwRangeListStr                         "" \
	-tacSeed                                 1 \
	-updateAmbrEnable                        false \
	-enableLifetime                          false \
	-pgwIpIncrementBy                        "0.0.0.0" \
	-enableMobility                          false \
	-attachType                              1 \
	-ignoreImsi                              false \
	-pgwIp                                   "20.0.0.1" \
	-mEI                                     "99990000000001" \
	-enableSV                                false \
	-sV                                      "11" \
	-updateAmbrIterations                    1 \
	-startDelay                              0 \
	-identityCount                           20 \
	-ambrIncrementBy                         1 \
	-maxDelayVariation                       0 \
	-selectionMode                           0 \
	-iMSI                                    "311180100000001" \
	-count                                   1 \
	-aPNRestriction                          0 \
	-fragmentation                           false \
	-ambrDL                                  1024 \
	-ipType                                  "IPv4" \
	-mSISDN                                  "9900000001" \
	-enabled                                 true \
	-unauthenticatedImsi                     false \
	-mobilityInterval                        60 \
	-relocateSgwOnLastENodeB                 false \
	-parentRange                             $eNB_R2 

$ENB enbAssociationList.clear



#################################################
# Creating the IP Distribution Groups
#################################################
$Traffic1_Network1 config \
	-enable                                  true \
	-tcpAccelerationAllowedFlag              false \
	-network                                 $Network1 

#################################################
# Network Activities for Traffic1@Network1
#################################################
set Activity_eGTP_Control_Plane [$Traffic1_Network1 networkActivityList.getNetworkActivityByPluginType $ENB "Control Plane"]

set _Match_Longest_ [::IxLoad new ixMatchLongestTimeline]



$Activity_eGTP_Control_Plane config \
	-enable                                  true \
	-timeline                                $_Match_Longest_ 

$Activity_eGTP_Control_Plane agent.config \
	-cmdListLoops                            0 \
	-flowPercentage                          100.0 

$Activity_eGTP_Control_Plane agent.pm.commands.clear

$Activity_eGTP_Control_Plane setPrimaryObjectiveType "None"

# Sub-activities are automatically added for each associated endpoint range
set Activity_eGTP_Control_Plane_numSubActivities [$Activity_eGTP_Control_Plane subActivities.indexCount]

#################################################
# Network Sub-activity for Range UE-R2
#################################################
set SubActivity_UE_R2 [$Activity_eGTP_Control_Plane subActivities.getItem 0]

#################################################
# Activity HTTPClient1 of NetTraffic Traffic1@Network1
#################################################
set Activity_HTTPClient1 [$Traffic1_Network1 activityList.appendItem -protocolAndType "HTTP Client"]

#################################################
# Timeline1 for activities HTTPClient1
#################################################
set Timeline1 [::IxLoad new ixTimeline]

$Timeline1 config \
	-rampUpValue                             1 \
	-rampUpType                              0 \
	-offlineTime                             0 \
	-rampDownTime                            20 \
	-standbyTime                             0 \
	-rampDownValue                           0 \
	-iterations                              1 \
	-rampUpInterval                          1 \
	-sustainTime                             20 \
	-timelineType                            0 \
	-name                                    "Timeline1" 

$Activity_HTTPClient1 config \
	-secondaryConstraintValue                100 \
	-enable                                  true \
	-name                                    "HTTPClient1" \
	-userIpMapping                           "1:1" \
	-enableConstraint                        false \
	-timerGranularity                        100 \
	-secondaryEnableConstraint               false \
	-constraintValue                         100 \
	-userObjectiveValue                      100 \
	-secondaryConstraintType                 "TransactionRateConstraint" \
	-constraintType                          "ConnectionRateConstraint" \
	-userObjectiveType                       "simulatedUsers" \
	-destinationIpMapping                    "Consecutive" \
	-timeline                                $Timeline1 

$Activity_HTTPClient1 agent.actionList.clear

set APN_1 [::IxLoad new ixNetworkCommand]

$APN_1 config -subType "egtpAPN"

set my_ixNetGTPNGQoSv1 [::IxLoad new ixNetGTPNGQoSv1]

$my_ixNetGTPNGQoSv1 config \
	-reliabilityClass                        2 \
	-sduErrorRatio                           6 \
	-maxBitRateDLEx                          0 \
	-allocationRetentionPriority             2 \
	-guaranteedBitRateUL                     64 \
	-maxSDUSize                              151 \
	-guaranteedBitRateDL                     64 \
	-signalingIndication                     0 \
	-_Stale                                  false \
	-deliveryOrder                           2 \
	-delayClass                              0 \
	-maxBitRateULEx                          0 \
	-guaranteedBitRateULEx                   0 \
	-peakThroughput                          6 \
	-precedenceClass                         2 \
	-maxBitRateDL                            8640 \
	-trafficHandlingPriority                 1 \
	-guaranteedBitRateDLEx                   0 \
	-meanThroughput                          31 \
	-maxBitRateUL                            8640 \
	-transferDelay                           4000 \
	-trafficClass                            4 \
	-deliveryOfErroneousSDU                  1 \
	-sourceStatisticsDescriptor              0 \
	-residualBER                             7 

set IMS [::IxLoad new ixNetEGTPApnEntry]

$IMS config \
	-restriction                             0 \
	-customAPNperIMSIFile                    "Click to set..." \
	-arpPreemptionCapability                 true \
	-ambrUL                                  1024 \
	-incrementAPN                            false \
	-enableStaticIpAllocation                false \
	-arpPriorityLevel                        1 \
	-lifetime                                100 \
	-override4Gto3GQosTransform              false \
	-s5s8InterfaceType                       "7" \
	-sendDNSServerIpPco                      false \
	-updateAmbrTimeout                       10 \
	-pgwIpCount                              1 \
	-_Stale                                  false \
	-apnRollover                             0 \
	-qci                                     5 \
	-enableLifetime                          false \
	-pgwIp                                   "50.10.10.13" \
	-incrementAPNType                        "0" \
	-override3Gto4GQosTransform              false \
	-updateAmbrIterations                    1 \
	-extendedName                            "IMS" \
	-useFullApn                              false \
	-updateAmbrIncrement                     10 \
	-selectionMode                           0 \
	-sendPcscfv4RequestPco                   false \
	-sendImcnFlagPco                         false \
	-ipType                                  "IPv4" \
	-updateAmbrEnable                        false \
	-pcoDns                                  2 \
	-arpPreemptionVulnerability              true \
	-ambrDL                                  1024 \
	-name                                    "IMS" \
	-mbru                                    1024 \
	-addressPoolStartIPv6                    "::AC10:65" \
	-addressPoolStartIPv4                    "172.16.0.1" \
	-enabled                                 true \
	-sendPcscfv6RequestPco                   false \
	-isEmergencyApn                          false \
	-mbrd                                    1024 \
	-imsAPN                                  false \
	-qosv1                                   $my_ixNetGTPNGQoSv1 

$APN_1 config \
	-usePredefinedQci                        true \
	-usePredefinedTft                        true \
	-displayName                             "APN" \
	-gbrd                                    100 \
	-mbru                                    100 \
	-protocolName                            "HTTP" \
	-tft                                     "3X0X03500050" \
	-defaultBearerFallback                   true \
	-networkInitiatedBearer                  false \
	-ignoreTFT                               false \
	-gbru                                    100 \
	-mbrd                                    100 \
	-_Stale                                  false \
	-qci                                     10 \
	-useDefaultBearer                        true \
	-apn                                     $IMS 

$APN_1 clear bearerList

set DedicatedBearer_9 [::IxLoad new ixNetEGTPCommandAPNBearer]

$DedicatedBearer_9 config \
	-function                                "none" \
	-usePredefinedQci                        true \
	-arpPreemptionVulnerability              true \
	-gbrd                                    100 \
	-mbru                                    100 \
	-arpPreemptionCapability                 true \
	-mbrd                                    100 \
	-ebi                                     "auto" \
	-tft                                     "3X0X03500050" \
	-defaultBearerFallback                   true \
	-networkInitiatedBearer                  false \
	-ignoreTFT                               false \
	-_Stale                                  false \
	-arpPriorityLevel                        1 \
	-gbru                                    100 \
	-qci                                     10 \
	-usePredefinedTft                        true \
	-matchArp                                false 

$APN_1 appendItem bearerList  -object $DedicatedBearer_9

$Activity_HTTPClient1 agent.actionList.appendItem -object $APN_1



set my_ixHttpCommand [::IxLoad new ixHttpCommand]

$my_ixHttpCommand config \
	-profile                                 -1 \
	-enableDi                                0 \
	-namevalueargs                           "" \
	-useSsl                                  0 \
	-pingFreq                                10 \
	-streamIden                              3 \
	-destination                             "Traffic2_HTTPServer1:80" \
	-sendMD5ChkSumHeader                     0 \
	-windowSize                              "65536" \
	-cmdName                                 "Get 2" \
	-method                                  -1 \
	-commandType                             "GET" \
	-abort                                   "None" \
	-arguments                               "" \
	-sslProfile                              -1 \
	-pageObject                              "/4k.html" \
	-sendingChunkSize                        "None" 

$Activity_HTTPClient1 agent.actionList.appendItem -object $my_ixHttpCommand



$Activity_HTTPClient1 agent.headerList.clear

set my_ixHttpHeaderString [::IxLoad new ixHttpHeaderString]

$my_ixHttpHeaderString config -data "Accept: */*"

$Activity_HTTPClient1 agent.headerList.appendItem -object $my_ixHttpHeaderString



set my_ixHttpHeaderString1 [::IxLoad new ixHttpHeaderString]

$my_ixHttpHeaderString1 config -data "Accept-Language: en-us"

$Activity_HTTPClient1 agent.headerList.appendItem -object $my_ixHttpHeaderString1



set my_ixHttpHeaderString2 [::IxLoad new ixHttpHeaderString]

$my_ixHttpHeaderString2 config -data "Accept-Encoding: gzip, deflate"

$Activity_HTTPClient1 agent.headerList.appendItem -object $my_ixHttpHeaderString2



set my_ixHttpHeaderString3 [::IxLoad new ixHttpHeaderString]

$my_ixHttpHeaderString3 config -data "User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 1.1.4322)"

$Activity_HTTPClient1 agent.headerList.appendItem -object $my_ixHttpHeaderString3



$Activity_HTTPClient1 agent.profileList.clear

$Activity_HTTPClient1 agent.methodProfileList.clear

$Activity_HTTPClient1 agent.sslProfileList.clear

$Activity_HTTPClient1 agent.config \
	-cmdListLoops                            0 \
	-vlanPriority                            0 \
	-validateCertificate                     0 \
	-enableDecompressSupport                 0 \
	-exactTransactions                       0 \
	-enableHttpsProxy                        0 \
	-perHeaderPercentDist                    0 \
	-enableSsl                               0 \
	-enablePerConnCookieSupport              0 \
	-cookieRejectProbability                 0.0 \
	-enableUnidirectionalClose               0 \
	-httpsTunnel                             "0.0.0.0" \
	-piggybackAck                            1 \
	-maxPersistentRequests                   1 \
	-enableEsm                               0 \
	-certificate                             "" \
	-sequentialSessionReuse                  0 \
	-browserEmulationName                    "Custom1" \
	-enableSslSendCloseNotify                0 \
	-cookieJarSize                           10 \
	-dontUseUpgrade                          0 \
	-maxPipeline                             1 \
	-contentLengthDeviationTolerance         0 \
	-caCert                                  "" \
	-maxSessions                             3 \
	-enableHttpProxy                         0 \
	-disableDnsResolutionCache               0 \
	-enableTrafficDistributionForCC          0 \
	-enableTos                               0 \
	-precedenceTOS                           0 \
	-ipPreference                            2 \
	-maxHeaderLen                            1024 \
	-flowPercentage                          100.0 \
	-maxStreams                              1 \
	-reliabilityTOS                          0 \
	-sslRecordSize                           "16384" \
	-privateKey                              "" \
	-commandTimeout                          600 \
	-enablemetaRedirectSupport               0 \
	-delayTOS                                0 \
	-enableIntegrityCheckSupport             0 \
	-commandTimeout_ms                       0 \
	-privateKeyPassword                      "" \
	-urlStatsCount                           10 \
	-followHttpRedirects                     0 \
	-tcpCloseOption                          0 \
	-enableVlanPriority                      0 \
	-esm                                     1460 \
	-httpVersion                             0 \
	-enablesslRecordSize                     0 \
	-sslReuseMethod                          0 \
	-sslVersion                              3 \
	-enableLargeHeader                       0 \
	-throughputTOS                           0 \
	-enableCookieSupport                     0 \
	-enableConsecutiveIpsPerSession          0 \
	-clientCiphers                           "DEFAULT" \
	-enableHttpsTunnel                       0 \
	-enableAchieveCCFirst                    0 \
	-tos                                     0 \
	-httpProxy                               "0.0.0.0" \
	-keepAlive                               0 \
	-enableCRCCheckSupport                   0 \
	-httpsProxy                              "0.0.0.0" 

$Activity_HTTPClient1 agent.cmdPercentagePool.percentageCommandList.clear

$Activity_HTTPClient1 agent.cmdPercentagePool.config -seed 1

$Traffic1_Network1 traffic.config -name "Traffic1"

$Traffic1_Network1 setPortOperationModeAllowed $::ixPort(kOperationModeThroughputAcceleration) false

$Traffic1_Network1 setPortOperationModeAllowed $::ixPort(kOperationModeFCoEOffload) true

$Traffic1_Network1 setPortOperationModeAllowed $::ixPort(kOperationModeL23) true

$Traffic1_Network1 setTcpAccelerationAllowed $::ixAgent(kTcpAcceleration) false

$Originate elementList.appendItem -object $Traffic1_Network1



$Originate config -name "Originate"

$TrafficFlow1 columnList.appendItem -object $Originate



set Terminate [::IxLoad new ixTrafficColumn]

$Terminate elementList.clear

$Terminate config -name "Terminate"

$TrafficFlow1 columnList.appendItem -object $Terminate



set Column1 [::IxLoad new ixTrafficColumn]

$Column1 elementList.clear

#################################################
# Create ScenarioElement kNetTraffic
#################################################
set Traffic2_Network2 [$scenarioElementFactory create $::ixScenarioElementType(kNetTraffic)]



#################################################
# Network Network2 of NetTraffic Traffic2@Network2
#################################################
set Network2 [$Traffic2_Network2 cget -network]

$Network2 portList.appendItem \
	-chassisId                               1 \
	-cardId                                  1 \
	-portId                                  3 

$Network2 globalPlugins.clear



set Settings_4 [::IxLoad new ixNetIxLoadSettingsPlugin]

# ixNet objects need to be added in the list before they are configured!
$Network2 globalPlugins.appendItem -object $Settings_4



$Settings_4 config \
	-teardownInterfaceWithUser               false \
	-_Stale                                  false \
	-interfaceBehavior                       0 

set Filter_4 [::IxLoad new ixNetFilterPlugin]

# ixNet objects need to be added in the list before they are configured!
$Network2 globalPlugins.appendItem -object $Filter_4



$Filter_4 config \
	-all                                     false \
	-pppoecontrol                            false \
	-isis                                    false \
	-auto                                    true \
	-udp                                     "" \
	-tcp                                     "" \
	-mac                                     "" \
	-_Stale                                  false \
	-pppoenetwork                            false \
	-ip                                      "" \
	-icmp                                    "" 

set GratARP_4 [::IxLoad new ixNetGratArpPlugin]

# ixNet objects need to be added in the list before they are configured!
$Network2 globalPlugins.appendItem -object $GratARP_4



$GratARP_4 config \
	-forwardGratArp                          false \
	-enabled                                 true \
	-maxFramesPerSecond                      0 \
	-_Stale                                  false \
	-rateControlEnabled                      false 

set TCP_4 [::IxLoad new ixNetTCPPlugin]

# ixNet objects need to be added in the list before they are configured!
$Network2 globalPlugins.appendItem -object $TCP_4



$TCP_4 config \
	-tcp_bic                                 0 \
	-tcp_tw_recycle                          true \
	-tcp_retries2                            5 \
	-disable_min_max_buffer_size             true \
	-tcp_retries1                            3 \
	-tcp_keepalive_time                      7200 \
	-tcp_mgmt_rmem                           87380 \
	-tcp_rfc1337                             false \
	-tcp_ipfrag_time                         30 \
	-tcp_rto_max                             120000 \
	-tcp_window_scaling                      false \
	-adjust_tcp_buffers                      true \
	-udp_port_randomization                  false \
	-tcp_vegas_alpha                         2 \
	-tcp_vegas_beta                          6 \
	-tcp_wmem_max                            262144 \
	-tcp_ecn                                 false \
	-tcp_westwood                            0 \
	-tcp_rto_min                             200 \
	-delayed_acks_segments                   0 \
	-tcp_vegas_cong_avoid                    0 \
	-tcp_keepalive_intvl                     75 \
	-tcp_rmem_max                            262144 \
	-tcp_orphan_retries                      0 \
	-bestPerfSettings                        false \
	-tcp_max_tw_buckets                      180000 \
	-_Stale                                  false \
	-tcp_low_latency                         0 \
	-tcp_rmem_min                            4096 \
	-accept_ra_all                           false \
	-tcp_adv_win_scale                       2 \
	-tcp_wmem_default                        4096 \
	-tcp_wmem_min                            4096 \
	-tcp_port_min                            1024 \
	-tcp_stdurg                              false \
	-tcp_port_max                            65535 \
	-tcp_fin_timeout                         60 \
	-tcp_no_metrics_save                     false \
	-tcp_dsack                               true \
	-tcp_mgmt_wmem                           32768 \
	-tcp_abort_on_overflow                   false \
	-tcp_frto                                0 \
	-tcp_mem_pressure                        32768 \
	-tcp_app_win                             31 \
	-ip_no_pmtu_disc                         true \
	-llm_hdr_gap                             8 \
	-tcp_max_orphans                         8192 \
	-accept_ra_default                       false \
	-tcp_syn_retries                         5 \
	-tcp_moderate_rcvbuf                     0 \
	-tcp_max_syn_backlog                     1024 \
	-tcp_mem_low                             24576 \
	-tcp_tw_rfc1323_strict                   false \
	-tcp_fack                                true \
	-tcp_retrans_collapse                    true \
	-inter_packet_granular_delay             0.0 \
	-llm_hdr_gap_ns                          10 \
	-tcp_large_icwnd                         0 \
	-tcp_rmem_default                        4096 \
	-tcp_keepalive_probes                    9 \
	-tcp_mem_high                            49152 \
	-tcp_tw_reuse                            false \
	-delayed_acks_timeout                    0 \
	-tcp_vegas_gamma                         2 \
	-delayed_acks                            true \
	-tcp_synack_retries                      5 \
	-tcp_timestamps                          true \
	-tcp_reordering                          3 \
	-rps_needed                              false \
	-tcp_sack                                true \
	-tcp_bic_fast_convergence                1 \
	-tcp_bic_low_window                      14 

set DNS_4 [::IxLoad new ixNetDnsPlugin]

# ixNet objects need to be added in the list before they are configured!
$Network2 globalPlugins.appendItem -object $DNS_4



$DNS_4 hostList.clear



$DNS_4 searchList.clear



$DNS_4 nameServerList.clear



$DNS_4 config \
	-domain                                  "" \
	-_Stale                                  false \
	-timeout                                 30 

set Meshing_2 [::IxLoad new ixNetMeshingPlugin]

# ixNet objects need to be added in the list before they are configured!
$Network2 globalPlugins.appendItem -object $Meshing_2



$Meshing_2 trafficMaps.clear



$Meshing_2 config -_Stale false

$Network2 config \
	-comment                                 "" \
	-name                                    "Network2" \
	-lineSpeed                               "Default" \
	-aggregation                             0 

set Ethernet_4 [$Network2 getL1Plugin]



set my_ixNetDataCenterSettings1 [::IxLoad new ixNetDataCenterSettings]

$my_ixNetDataCenterSettings1 dcPfcMapping.clear



$my_ixNetDataCenterSettings1 config \
	-dcSupported                             true \
	-dcEnabled                               false \
	-dcPfcPauseDelay                         1 \
	-_Stale                                  false \
	-dcMode                                  2 \
	-dcPfcPauseEnable                        false \
	-dcFlowControl                           0 

set my_ixNetEthernetELMPlugin1 [::IxLoad new ixNetEthernetELMPlugin]

$my_ixNetEthernetELMPlugin1 config \
	-negotiationType                         "master" \
	-_Stale                                  false \
	-negotiateMasterSlave                    true 

set my_ixNetDualPhyPlugin1 [::IxLoad new ixNetDualPhyPlugin]

$my_ixNetDualPhyPlugin1 config \
	-medium                                  "auto" \
	-_Stale                                  false 

$Ethernet_4 childrenList.clear



set MAC_VLAN_5 [::IxLoad new ixNetL2EthernetPlugin]

# ixNet objects need to be added in the list before they are configured!
$Ethernet_4 childrenList.appendItem -object $MAC_VLAN_5



$MAC_VLAN_5 childrenList.clear



set IP_3 [::IxLoad new ixNetIpV4V6Plugin]

# ixNet objects need to be added in the list before they are configured!
$MAC_VLAN_5 childrenList.appendItem -object $IP_3



$IP_3 childrenList.clear



$IP_3 extensionList.clear



$IP_3 config -_Stale false

$MAC_VLAN_5 extensionList.clear



$MAC_VLAN_5 config -_Stale false

$Ethernet_4 extensionList.clear



$Ethernet_4 config \
	-advertise10Full                         true \
	-directedAddress                         "01:80:C2:00:00:01" \
	-autoNegotiate                           true \
	-advertise100Half                        true \
	-advertise10Half                         true \
	-enableFlowControl                       false \
	-_Stale                                  false \
	-speed                                   "k100FD" \
	-advertise1000Full                       true \
	-advertise100Full                        true \
	-dataCenter                              $my_ixNetDataCenterSettings1 \
	-cardElm                                 $my_ixNetEthernetELMPlugin1 \
	-cardDualPhy                             $my_ixNetDualPhyPlugin1 

#################################################
# Setting the ranges starting with the plugins that need to be script gen first
#################################################
$IP_3 rangeList.clear

set IP_R4 [::IxLoad new ixNetIpV4V6Range]

# ixNet objects need to be added in the list before they are configured.
$IP_3 rangeList.appendItem -object $IP_R4



$IP_R4 config \
	-count                                   1 \
	-enableGatewayArp                        false \
	-randomizeSeed                           1925178911 \
	-generateStatistics                      false \
	-autoIpTypeEnabled                       false \
	-autoCountEnabled                        false \
	-enabled                                 true \
	-autoMacGeneration                       true \
	-publishStats                            false \
	-incrementBy                             "0.0.0.1" \
	-prefix                                  24 \
	-_Stale                                  false \
	-gatewayIncrement                        "0.0.0.0" \
	-gatewayIncrementMode                    "perSubnet" \
	-mss                                     1460 \
	-randomizeAddress                        false \
	-gatewayAddress                          "172.32.2.254" \
	-ipAddress                               "172.32.2.200" \
	-ipType                                  "IPv4" 

set MAC_R5 [$IP_R4 getLowerRelatedRange "MacRange"]

$MAC_R5 config \
	-count                                   1 \
	-enabled                                 true \
	-mtu                                     1500 \
	-mac                                     "00:AC:20:02:C8:00" \
	-_Stale                                  false \
	-incrementBy                             "00:00:00:00:00:01" 

set VLAN_R4 [$IP_R4 getLowerRelatedRange "VlanIdRange"]

$VLAN_R4 config \
	-incrementStep                           1 \
	-innerIncrement                          1 \
	-uniqueCount                             4094 \
	-firstId                                 1 \
	-tpid                                    "0x8100" \
	-idIncrMode                              2 \
	-enabled                                 false \
	-innerFirstId                            1 \
	-innerIncrementStep                      1 \
	-priority                                1 \
	-_Stale                                  false \
	-increment                               1 \
	-innerTpid                               "0x8100" \
	-innerUniqueCount                        4094 \
	-innerEnable                             false \
	-innerPriority                           1 

#################################################
# Creating the IP Distribution Groups
#################################################
$IP_3 rangeGroups.clear



set DistGroup1 [::IxLoad new ixNetRangeGroup]

# ixNet objects need to be added in the list before they are configured!
$IP_3 rangeGroups.appendItem -object $DistGroup1



# ixNet objects need to be added in the list before they are configured.
$DistGroup1 rangeList.appendItem -object $IP_R4



$DistGroup1 config \
	-distribType                             0 \
	-_Stale                                  false \
	-name                                    "DistGroup1" 

$Traffic2_Network2 config \
	-enable                                  1 \
	-tcpAccelerationAllowedFlag              true \
	-network                                 $Network2 

#################################################
# Activity HTTPServer1 of NetTraffic Traffic2@Network2
#################################################
set Activity_HTTPServer1 [$Traffic2_Network2 activityList.appendItem -protocolAndType "HTTP Server"]

set _Match_Longest_1 [::IxLoad new ixMatchLongestTimeline]



$Activity_HTTPServer1 config \
	-enable                                  true \
	-name                                    "HTTPServer1" \
	-timeline                                $_Match_Longest_1 

$Activity_HTTPServer1 agent.webPageList.clear

set _200_OK [::IxLoad new ResponseHeader]

$_200_OK responseList.clear

$_200_OK config \
	-mimeType                                "text/plain" \
	-expirationMode                          0 \
	-code                                    "200" \
	-dateIncrementFor                        1 \
	-name                                    "200_OK" \
	-lastModifiedMode                        1 \
	-lastModifiedIncrementEnable             false \
	-enableCustomPutResponse                 false \
	-dateIncrementEnable                     false \
	-lastModifiedDateTimeValue               "2017/10/26 09:09:40" \
	-lastModifiedIncrementFor                1 \
	-expirationAfterLastModifiedValue        3600 \
	-dateTimeValue                           "2017/10/26 09:09:40" \
	-dateZone                                "GMT" \
	-dateMode                                2 \
	-expirationAfterRequestValue             3600 \
	-dateIncrementBy                         5 \
	-expirationDateTimeValue                 "2017/11/25 09:09:40" \
	-lastModifiedIncrementBy                 5 \
	-description                             "OK" 

set my_PageObject [::IxLoad new PageObject]

$my_PageObject config \
	-chunkSize                               "1" \
	-Md5Option                               3 \
	-payloadSize                             "1-1" \
	-customPayloadId                         -1 \
	-payloadType                             "range" \
	-payloadFile                             "<specify file>" \
	-page                                    "/1b.html" \
	-response                                $_200_OK 

$Activity_HTTPServer1 agent.webPageList.appendItem -object $my_PageObject



set my_PageObject1 [::IxLoad new PageObject]

$my_PageObject1 config \
	-chunkSize                               "512-1024" \
	-Md5Option                               3 \
	-payloadSize                             "4096-4096" \
	-customPayloadId                         -1 \
	-payloadType                             "range" \
	-payloadFile                             "<specify file>" \
	-page                                    "/4k.html" \
	-response                                $_200_OK 

$Activity_HTTPServer1 agent.webPageList.appendItem -object $my_PageObject1



set my_PageObject2 [::IxLoad new PageObject]

$my_PageObject2 config \
	-chunkSize                               "512-1024" \
	-Md5Option                               3 \
	-payloadSize                             "8192-8192" \
	-customPayloadId                         -1 \
	-payloadType                             "range" \
	-payloadFile                             "<specify file>" \
	-page                                    "/8k.html" \
	-response                                $_200_OK 

$Activity_HTTPServer1 agent.webPageList.appendItem -object $my_PageObject2



set my_PageObject3 [::IxLoad new PageObject]

$my_PageObject3 config \
	-chunkSize                               "512-1024" \
	-Md5Option                               3 \
	-payloadSize                             "16536-16536" \
	-customPayloadId                         -1 \
	-payloadType                             "range" \
	-payloadFile                             "<specify file>" \
	-page                                    "/16k.html" \
	-response                                $_200_OK 

$Activity_HTTPServer1 agent.webPageList.appendItem -object $my_PageObject3



set my_PageObject4 [::IxLoad new PageObject]

$my_PageObject4 config \
	-chunkSize                               "512-1024" \
	-Md5Option                               3 \
	-payloadSize                             "32768" \
	-customPayloadId                         -1 \
	-payloadType                             "range" \
	-payloadFile                             "<specify file>" \
	-page                                    "/32k.html" \
	-response                                $_200_OK 

$Activity_HTTPServer1 agent.webPageList.appendItem -object $my_PageObject4



set my_PageObject5 [::IxLoad new PageObject]

$my_PageObject5 config \
	-chunkSize                               "512-1024" \
	-Md5Option                               3 \
	-payloadSize                             "65536" \
	-customPayloadId                         -1 \
	-payloadType                             "range" \
	-payloadFile                             "<specify file>" \
	-page                                    "/64k.html" \
	-response                                $_200_OK 

$Activity_HTTPServer1 agent.webPageList.appendItem -object $my_PageObject5



set my_PageObject6 [::IxLoad new PageObject]

$my_PageObject6 config \
	-chunkSize                               "512-1024" \
	-Md5Option                               3 \
	-payloadSize                             "131072" \
	-customPayloadId                         -1 \
	-payloadType                             "range" \
	-payloadFile                             "<specify file>" \
	-page                                    "/128k.html" \
	-response                                $_200_OK 

$Activity_HTTPServer1 agent.webPageList.appendItem -object $my_PageObject6



set my_PageObject7 [::IxLoad new PageObject]

$my_PageObject7 config \
	-chunkSize                               "512-1024" \
	-Md5Option                               3 \
	-payloadSize                             "262144" \
	-customPayloadId                         -1 \
	-payloadType                             "range" \
	-payloadFile                             "<specify file>" \
	-page                                    "/256k.html" \
	-response                                $_200_OK 

$Activity_HTTPServer1 agent.webPageList.appendItem -object $my_PageObject7



set my_PageObject8 [::IxLoad new PageObject]

$my_PageObject8 config \
	-chunkSize                               "512-1024" \
	-Md5Option                               3 \
	-payloadSize                             "524288" \
	-customPayloadId                         -1 \
	-payloadType                             "range" \
	-payloadFile                             "<specify file>" \
	-page                                    "/512k.html" \
	-response                                $_200_OK 

$Activity_HTTPServer1 agent.webPageList.appendItem -object $my_PageObject8



set my_PageObject9 [::IxLoad new PageObject]

$my_PageObject9 config \
	-chunkSize                               "512-1024" \
	-Md5Option                               3 \
	-payloadSize                             "1048576" \
	-customPayloadId                         -1 \
	-payloadType                             "range" \
	-payloadFile                             "<specify file>" \
	-page                                    "/1024k.html" \
	-response                                $_200_OK 

$Activity_HTTPServer1 agent.webPageList.appendItem -object $my_PageObject9



$Activity_HTTPServer1 agent.cookieList.clear

set UserCookie [::IxLoad new CookieObject]

$UserCookie cookieContentList.clear

set firstName [::IxLoad new ixCookieContent]

$firstName config \
	-domain                                  "" \
	-name                                    "firstName" \
	-maxAge                                  "" \
	-value                                   "Joe" \
	-other                                   "" \
	-path                                    "" 

$UserCookie cookieContentList.appendItem -object $firstName



set lastName [::IxLoad new ixCookieContent]

$lastName config \
	-domain                                  "" \
	-name                                    "lastName" \
	-maxAge                                  "" \
	-value                                   "Smith" \
	-other                                   "" \
	-path                                    "" 

$UserCookie cookieContentList.appendItem -object $lastName



$UserCookie config \
	-mode                                    3 \
	-type                                    2 \
	-name                                    "UserCookie" \
	-description                             "Name of User" 

$Activity_HTTPServer1 agent.cookieList.appendItem -object $UserCookie



set LoginCookie [::IxLoad new CookieObject]

$LoginCookie cookieContentList.clear

set name [::IxLoad new ixCookieContent]

$name config \
	-domain                                  "" \
	-name                                    "name" \
	-maxAge                                  "" \
	-value                                   "joesmith" \
	-other                                   "" \
	-path                                    "" 

$LoginCookie cookieContentList.appendItem -object $name



set password [::IxLoad new ixCookieContent]

$password config \
	-domain                                  "" \
	-name                                    "password" \
	-maxAge                                  "" \
	-value                                   "foobar" \
	-other                                   "" \
	-path                                    "" 

$LoginCookie cookieContentList.appendItem -object $password



$LoginCookie config \
	-mode                                    2 \
	-type                                    2 \
	-name                                    "LoginCookie" \
	-description                             "Login name and password" 

$Activity_HTTPServer1 agent.cookieList.appendItem -object $LoginCookie



$Activity_HTTPServer1 agent.customPayloadList.clear

set AsciiCustomPayload [::IxLoad new CustomPayloadObject]

$AsciiCustomPayload config \
	-repeat                                  0 \
	-name                                    "AsciiCustomPayload" \
	-asciiPayloadValue                       "Ixia-Ixload-Http-Server-Custom-Payload" \
	-payloadmode                             0 \
	-offset                                  1 \
	-hexPayloadValue                         "" \
	-payloadPosition                         "Start With" \
	-id                                      0 

$Activity_HTTPServer1 agent.customPayloadList.appendItem -object $AsciiCustomPayload



set HexCustomPayload [::IxLoad new CustomPayloadObject]

$HexCustomPayload config \
	-repeat                                  0 \
	-name                                    "HexCustomPayload" \
	-asciiPayloadValue                       "" \
	-payloadmode                             1 \
	-offset                                  1 \
	-hexPayloadValue                         "49 78 69 61 2d 49 78 6c 6f 61 64 2d 48 74 74 70 2d 53 65 72 76 65 72 2d 43 75 73 74 6f 6d 2d 50 61 79 6c 6f 61 64" \
	-payloadPosition                         "Start With" \
	-id                                      1 

$Activity_HTTPServer1 agent.customPayloadList.appendItem -object $HexCustomPayload



$Activity_HTTPServer1 agent.responseHeaderList.clear

set _201 [::IxLoad new ResponseHeader]

$_201 responseList.clear

$_201 config \
	-mimeType                                "text/plain" \
	-expirationMode                          0 \
	-code                                    "200" \
	-dateIncrementFor                        1 \
	-name                                    "200_OK" \
	-lastModifiedMode                        1 \
	-lastModifiedIncrementEnable             false \
	-enableCustomPutResponse                 false \
	-dateIncrementEnable                     false \
	-lastModifiedDateTimeValue               "2017/10/26 09:09:40" \
	-lastModifiedIncrementFor                1 \
	-expirationAfterLastModifiedValue        3600 \
	-dateTimeValue                           "2017/10/26 09:09:40" \
	-dateZone                                "GMT" \
	-dateMode                                2 \
	-expirationAfterRequestValue             3600 \
	-dateIncrementBy                         5 \
	-expirationDateTimeValue                 "2017/11/25 09:09:40" \
	-lastModifiedIncrementBy                 5 \
	-description                             "OK" 

$Activity_HTTPServer1 agent.responseHeaderList.appendItem -object $_201



set _404_PageNotFound [::IxLoad new ResponseHeader]

$_404_PageNotFound responseList.clear

$_404_PageNotFound config \
	-mimeType                                "text/plain" \
	-expirationMode                          0 \
	-code                                    404 \
	-dateIncrementFor                        1 \
	-name                                    "404_PageNotFound" \
	-lastModifiedMode                        1 \
	-lastModifiedIncrementEnable             false \
	-enableCustomPutResponse                 false \
	-dateIncrementEnable                     false \
	-lastModifiedDateTimeValue               "2017/10/26 09:09:40" \
	-lastModifiedIncrementFor                1 \
	-expirationAfterLastModifiedValue        3600 \
	-dateTimeValue                           "2017/10/26 09:09:40" \
	-dateZone                                "GMT" \
	-dateMode                                2 \
	-expirationAfterRequestValue             3600 \
	-dateIncrementBy                         5 \
	-expirationDateTimeValue                 "2017/11/25 09:09:40" \
	-lastModifiedIncrementBy                 5 \
	-description                             "Page not found" 

$Activity_HTTPServer1 agent.responseHeaderList.appendItem -object $_404_PageNotFound



$Activity_HTTPServer1 agent.config \
	-cmdListLoops                            0 \
	-vlanPriority                            0 \
	-validateCertificate                     0 \
	-maxResponseDelay                        0 \
	-docrootChunkSize                        "512-1024" \
	-rstTimeout                              100 \
	-enableChunkedRequest                    false \
	-enableEsm                               0 \
	-enableHTTP2                             false \
	-certificate                             "" \
	-enableNewSslSupport                     false \
	-tos                                     0 \
	-enableSslSendCloseNotify                0 \
	-enableMD5Checksum                       false \
	-httpPort                                "80" \
	-httpsPort                               "443" \
	-caCert                                  "" \
	-esm                                     1460 \
	-enableTos                               0 \
	-precedenceTOS                           0 \
	-integrityCheckOption                    "Custom MD5" \
	-flowPercentage                          100.0 \
	-enableChunkEncoding                     false \
	-privateKey                              "" \
	-sslRecordSize                           "16384" \
	-reliabilityTOS                          0 \
	-delayTOS                                0 \
	-privateKeyPassword                      "" \
	-urlStatsCount                           10 \
	-tcpCloseOption                          0 \
	-enableVlanPriority                      0 \
	-enableIntegrityCheck                    0 \
	-docrootfile                             "" \
	-enablesslRecordSize                     0 \
	-dhParams                                "" \
	-throughputTOS                           0 \
	-requestTimeout                          300 \
	-dontExpectUpgrade                       false \
	-ServerCiphers                           "DEFAULT" \
	-enableDHsupport                         0 \
	-enablePerServerPerURLstat               0 \
	-urlPageSize                             1024 \
	-acceptSslConnections                    0 \
	-minResponseDelay                        0 

$Traffic2_Network2 traffic.config -name "Traffic2"

$Traffic2_Network2 setPortOperationModeAllowed $::ixPort(kOperationModeThroughputAcceleration) false

$Traffic2_Network2 setPortOperationModeAllowed $::ixPort(kOperationModeFCoEOffload) true

$Traffic2_Network2 setPortOperationModeAllowed $::ixPort(kOperationModeL23) true

$Traffic2_Network2 setTcpAccelerationAllowed $::ixAgent(kTcpAcceleration) true

$Column1 elementList.appendItem -object $Traffic2_Network2



$Column1 config -name "Column1"

$TrafficFlow1 columnList.appendItem -object $Column1



$TrafficFlow1 appMixList.clear

$TrafficFlow1 links.clear

$TrafficFlow1 config -name "TrafficFlow1"

$Test1 config \
	-comment                                 "" \
	-networkFailureThreshold                 0 \
	-statViewThroughputUnits                 "Kbps" \
	-showNetworkDiagnosticsAfterRunStops     false \
	-csvThroughputScalingFactor              1000 \
	-enableReleaseConfigAfterRun             false \
	-activitiesGroupedByObjective            false \
	-resetNetworkDiagnosticsAtStartRun       true \
	-enableFrameSizeDistributionStats        false \
	-enableTcpAdvancedStats                  false \
	-showNetworkDiagnosticsFromApplyConfig   true \
	-enableResetPorts                        true \
	-enableNetworkDiagnosticsLogging         true \
	-csvInterval                             2 \
	-name                                    "Test1" \
	-downgradeAppLibFlowsToLatestValidVersion true \
	-statsRequired                           true \
	-isFrameSizeDistributionViewSupported    false \
	-enableForceOwnership                    false \
	-enableNetworkDiagnostics                true \
	-allowMixedObjectiveTypes                false \
	-currentUniqueIDForAgent                 30 \
	-profileDirectory                        $profileDirectory \
	-eventHandlerSettings                    $my_ixEventHandlerSettings \
	-captureViewOptions                      $my_ixViewOptions 

#################################################
# Destination HTTPServer1 for HTTPClient1
#################################################
set destination [$Traffic1_Network1 getDestinationForActivity "HTTPClient1" "Traffic2_HTTPServer1"]

$destination config -portMapPolicy "portPairs"

#################################################
# Session Specific Settings
#################################################
set my_ixNetMacSessionData [$Test1 getSessionSpecificData "L2EthernetPlugin"]

$my_ixNetMacSessionData config \
	-_Stale                                  false \
	-duplicateCheckingScope                  2 

set my_ixNetIpSessionData [$Test1 getSessionSpecificData "IpV4V6Plugin"]

$my_ixNetIpSessionData config \
	-enableGatewayArp                        false \
	-ignoreUnresolvedIPs                     false \
	-individualARPTimeOut                    500 \
	-maxOutstandingGatewayArpRequests        300 \
	-_Stale                                  false \
	-sendAllRequests                         false \
	-gatewayArpRequestRate                   300 \
	-duplicateCheckingScope                  2 

set my_ixNetEGTPPluginSessionData [$Test1 getSessionSpecificData "EGTPPlugin"]

set my_ixNetEGTPDnsBlaster [::IxLoad new ixNetEGTPDnsBlaster]

$my_ixNetEGTPDnsBlaster domainNames.clear



set my_ixNetEGTPDnsName [::IxLoad new ixNetEGTPDnsName]

# ixNet objects need to be added in the list before they are configured!
$my_ixNetEGTPDnsBlaster domainNames.appendItem -object $my_ixNetEGTPDnsName



$my_ixNetEGTPDnsName config \
	-dnsName                                 "ns-1.ixiacom.com" \
	-_Stale                                  false 

$my_ixNetEGTPDnsBlaster config \
	-enabled                                 false \
	-maxSizeRange                            1 \
	-_Stale                                  false \
	-timeout                                 0 \
	-nameServerIP                            "127.0.0.1" \
	-sourcePort                              53 

$my_ixNetEGTPPluginSessionData qci2TosMap.clear



set my_ixNetEGTPQci2TosEntry [::IxLoad new ixNetEGTPQci2TosEntry]

# ixNet objects need to be added in the list before they are configured!
$my_ixNetEGTPPluginSessionData qci2TosMap.appendItem -object $my_ixNetEGTPQci2TosEntry



$my_ixNetEGTPQci2TosEntry config \
	-tos                                     "10" \
	-qci                                     1 \
	-enable                                  true \
	-_Stale                                  false 

set my_ixNetEGTPQci3 [::IxLoad new ixNetEGTPQci2TosEntry]

# ixNet objects need to be added in the list before they are configured!
$my_ixNetEGTPPluginSessionData qci2TosMap.appendItem -object $my_ixNetEGTPQci3



$my_ixNetEGTPQci3 config \
	-tos                                     "10" \
	-qci                                     2 \
	-enable                                  true \
	-_Stale                                  false 

set my_ixNetEGTPQci4 [::IxLoad new ixNetEGTPQci2TosEntry]

# ixNet objects need to be added in the list before they are configured!
$my_ixNetEGTPPluginSessionData qci2TosMap.appendItem -object $my_ixNetEGTPQci4



$my_ixNetEGTPQci4 config \
	-tos                                     "10" \
	-qci                                     3 \
	-enable                                  true \
	-_Stale                                  false 

set my_ixNetEGTPQci5 [::IxLoad new ixNetEGTPQci2TosEntry]

# ixNet objects need to be added in the list before they are configured!
$my_ixNetEGTPPluginSessionData qci2TosMap.appendItem -object $my_ixNetEGTPQci5



$my_ixNetEGTPQci5 config \
	-tos                                     "10" \
	-qci                                     4 \
	-enable                                  true \
	-_Stale                                  false 

set my_ixNetEGTPQci6 [::IxLoad new ixNetEGTPQci2TosEntry]

# ixNet objects need to be added in the list before they are configured!
$my_ixNetEGTPPluginSessionData qci2TosMap.appendItem -object $my_ixNetEGTPQci6



$my_ixNetEGTPQci6 config \
	-tos                                     "10" \
	-qci                                     5 \
	-enable                                  true \
	-_Stale                                  false 

set my_ixNetEGTPQci7 [::IxLoad new ixNetEGTPQci2TosEntry]

# ixNet objects need to be added in the list before they are configured!
$my_ixNetEGTPPluginSessionData qci2TosMap.appendItem -object $my_ixNetEGTPQci7



$my_ixNetEGTPQci7 config \
	-tos                                     "10" \
	-qci                                     6 \
	-enable                                  true \
	-_Stale                                  false 

set my_ixNetEGTPQci8 [::IxLoad new ixNetEGTPQci2TosEntry]

# ixNet objects need to be added in the list before they are configured!
$my_ixNetEGTPPluginSessionData qci2TosMap.appendItem -object $my_ixNetEGTPQci8



$my_ixNetEGTPQci8 config \
	-tos                                     "10" \
	-qci                                     7 \
	-enable                                  true \
	-_Stale                                  false 

set my_ixNetEGTPQci9 [::IxLoad new ixNetEGTPQci2TosEntry]

# ixNet objects need to be added in the list before they are configured!
$my_ixNetEGTPPluginSessionData qci2TosMap.appendItem -object $my_ixNetEGTPQci9



$my_ixNetEGTPQci9 config \
	-tos                                     "10" \
	-qci                                     8 \
	-enable                                  true \
	-_Stale                                  false 

set my_ixNetEGTPQci10 [::IxLoad new ixNetEGTPQci2TosEntry]

# ixNet objects need to be added in the list before they are configured!
$my_ixNetEGTPPluginSessionData qci2TosMap.appendItem -object $my_ixNetEGTPQci10



$my_ixNetEGTPQci10 config \
	-tos                                     "10" \
	-qci                                     9 \
	-enable                                  true \
	-_Stale                                  false 

$my_ixNetEGTPPluginSessionData config \
	-enableGatewayArp                        false \
	-maxOutstandingRequests                  25 \
	-useMaxRatesForDcp                       false \
	-ignoreUnresolvedIPs                     false \
	-individualARPTimeOut                    500 \
	-maxMbrUAndD                             1099511627775 \
	-tsSpec                                  "R9_DECEMBER2010_SPEC" \
	-enableDynamicQosCtrl                    false \
	-maxOutstandingReleases                  25 \
	-maxOutstandingGatewayArpRequests        300 \
	-_Stale                                  false \
	-sendAllRequests                         false \
	-setupRateInitial                        25 \
	-teardownRateInitial                     25 \
	-gatewayArpRequestRate                   300 \
	-duplicateCheckingScope                  1 \
	-dnsBlaster                              $my_ixNetEGTPDnsBlaster 

#################################################
# Network Specific Settings(overrides some of the session specific settings)
#################################################
# If the 'override' property is set to true the specific settings for this network will overidde the session specifc settings
set my_ixNetEGTPPluginPortGroupData [$Network1 getNetworkSpecificData "EGTPPlugin"]

$my_ixNetEGTPPluginPortGroupData activities.clear



$my_ixNetEGTPPluginPortGroupData associates.clear



$my_ixNetEGTPPluginPortGroupData apnList.clear



# ixNet objects need to be added in the list before they are configured!
$my_ixNetEGTPPluginPortGroupData apnList.appendItem -object $IMS



$my_ixNetEGTPPluginPortGroupData config \
	-arp                                     7 \
	-maxOutstandingReleases                  25 \
	-alwaysSendCStoVIP                       true \
	-alwaysIncludeRecoveryIE                 false \
	-enableIPDefragmentation                 false \
	-deleteIdleBearers                       false \
	-s5s8InterfaceType                       "" \
	-enableResponseCache                     false \
	-_Stale                                  false \
	-qci                                     9 \
	-pcpuLogLevel                            "0" \
	-enableDifferentTeidPerENodeB            false \
	-gbrd                                    65536 \
	-priorityLevel                           1 \
	-preemptionVulnerability                 true \
	-preemptionCapability                    true \
	-gbru                                    65536 \
	-delayMBReq                              0 \
	-teardownRateInitial                     25 \
	-maxOutstandingRequests                  25 \
	-mbru                                    65536 \
	-responseCacheRotationInterval           15 \
	-includeGtpuSeqNumber                    false \
	-overrideGlobalRateControls              false \
	-enableGtpuSequenceNumber                false \
	-mbrd                                    65536 \
	-suppressErrorIndication                 false \
	-setupRateInitial                        25 

# If the 'override' property is set to true the specific settings for this network will overidde the session specifc settings
set my_ixNetSM_DNSPluginPortGroupData [$Network1 getNetworkSpecificData "SM_DNSPlugin"]

$my_ixNetSM_DNSPluginPortGroupData activities.clear



$my_ixNetSM_DNSPluginPortGroupData associates.clear



$my_ixNetSM_DNSPluginPortGroupData config \
	-_Stale                                  false \
	-pcpuLogLevel                            "1" 

#################################################
# Create the test controller to run the test
#################################################
set testController [::IxLoad new ixTestController  -outputDir true]



$testController setResultDir "RESULTS\\IxLoad_sgw_failure"

$Traffic1_Network1 setCommunityCaptureParams $Test1 true

$Network1 portList(0).setAnalyzerPartialCapture "False;8192"


$testController run $Test1

vwait ::ixTestControllerMonitor
puts $::ixTestControllerMonitor

#
# Wait for the rest of the capture data
#
if {$::ixCaptureMonitor == ""} {
    puts "Waiting for last capture data to arrive."
    vwait ::ixCaptureMonitor
    puts "Capture data received."
} 

#################################################
# Cleanup
#################################################
# Release config is only strictly necessary if enableReleaseConfigAfterRun is 0.
$testController releaseConfig

vwait ::ixTestControllerMonitor
puts $::ixTestControllerMonitor

$Test1 clearDUTList

$Traffic1_Network1 removeAllPortsFromAnalyzer

$Traffic2_Network2 removeAllPortsFromAnalyzer

::IxLoad delete $chassisChain

::IxLoad delete $Test1

::IxLoad delete $profileDirectory

::IxLoad delete $my_ixEventHandlerSettings

::IxLoad delete $my_ixViewOptions

::IxLoad delete $TrafficFlow1

::IxLoad delete $Originate

::IxLoad delete $Traffic1_Network1

::IxLoad delete $Network1

::IxLoad delete $Settings_1

::IxLoad delete $Filter_1

::IxLoad delete $GratARP_1

::IxLoad delete $TCP_1

::IxLoad delete $DNS_1

::IxLoad delete $Meshing_1

::IxLoad delete $HTTPClient1_Traffic2_HTTPServer1

::IxLoad delete $Ethernet_1

::IxLoad delete $my_ixNetDataCenterSettings

::IxLoad delete $my_ixNetEthernetELMPlugin

::IxLoad delete $my_ixNetDualPhyPlugin

::IxLoad delete $MAC_ENB

::IxLoad delete $IP_ENB

::IxLoad delete $ENB

::IxLoad delete $MAC_MME

::IxLoad delete $IP_MME

::IxLoad delete $SM_DNS_1

::IxLoad delete $my_ixNetEGTPNetworkActivity

::IxLoad delete $my_ixNetEGTPNetworkActivitySettings

::IxLoad delete $SGWPool_1

::IxLoad delete $SM_DCPProxy_1

::IxLoad delete $MME_R2

::IxLoad delete $my_ixNetEGTPSGWPoolEntry

::IxLoad delete $DNS_R1

::IxLoad delete $IP_R5

::IxLoad delete $MAC_R3

::IxLoad delete $VLAN_R5

::IxLoad delete $eNB_R2

::IxLoad delete $IP_R1

::IxLoad delete $MAC_R1

::IxLoad delete $VLAN_R1

::IxLoad delete $UE_R2

::IxLoad delete $Activity_eGTP_Control_Plane

::IxLoad delete $_Match_Longest_

::IxLoad delete $SubActivity_UE_R2

::IxLoad delete $Activity_HTTPClient1

::IxLoad delete $Timeline1

::IxLoad delete $APN_1

::IxLoad delete $IMS

::IxLoad delete $my_ixNetGTPNGQoSv1

::IxLoad delete $DedicatedBearer_9

::IxLoad delete $my_ixHttpCommand

::IxLoad delete $my_ixHttpHeaderString

::IxLoad delete $my_ixHttpHeaderString1

::IxLoad delete $my_ixHttpHeaderString2

::IxLoad delete $my_ixHttpHeaderString3

::IxLoad delete $Terminate

::IxLoad delete $Column1

::IxLoad delete $Traffic2_Network2

::IxLoad delete $Network2

::IxLoad delete $Settings_4

::IxLoad delete $Filter_4

::IxLoad delete $GratARP_4

::IxLoad delete $TCP_4

::IxLoad delete $DNS_4

::IxLoad delete $Meshing_2

::IxLoad delete $Ethernet_4

::IxLoad delete $my_ixNetDataCenterSettings1

::IxLoad delete $my_ixNetEthernetELMPlugin1

::IxLoad delete $my_ixNetDualPhyPlugin1

::IxLoad delete $MAC_VLAN_5

::IxLoad delete $IP_3

::IxLoad delete $IP_R4

::IxLoad delete $MAC_R5

::IxLoad delete $VLAN_R4

::IxLoad delete $DistGroup1

::IxLoad delete $Activity_HTTPServer1

::IxLoad delete $_Match_Longest_1

::IxLoad delete $my_PageObject

::IxLoad delete $_200_OK

::IxLoad delete $my_PageObject1

::IxLoad delete $my_PageObject2

::IxLoad delete $my_PageObject3

::IxLoad delete $my_PageObject4

::IxLoad delete $my_PageObject5

::IxLoad delete $my_PageObject6

::IxLoad delete $my_PageObject7

::IxLoad delete $my_PageObject8

::IxLoad delete $my_PageObject9

::IxLoad delete $UserCookie

::IxLoad delete $firstName

::IxLoad delete $lastName

::IxLoad delete $LoginCookie

::IxLoad delete $name

::IxLoad delete $password

::IxLoad delete $AsciiCustomPayload

::IxLoad delete $HexCustomPayload

::IxLoad delete $_201

::IxLoad delete $_404_PageNotFound

::IxLoad delete $destination

::IxLoad delete $my_ixNetMacSessionData

::IxLoad delete $my_ixNetIpSessionData

::IxLoad delete $my_ixNetEGTPPluginSessionData

::IxLoad delete $my_ixNetEGTPDnsBlaster

::IxLoad delete $my_ixNetEGTPDnsName

::IxLoad delete $my_ixNetEGTPQci2TosEntry

::IxLoad delete $my_ixNetEGTPQci3

::IxLoad delete $my_ixNetEGTPQci4

::IxLoad delete $my_ixNetEGTPQci5

::IxLoad delete $my_ixNetEGTPQci6

::IxLoad delete $my_ixNetEGTPQci7

::IxLoad delete $my_ixNetEGTPQci8

::IxLoad delete $my_ixNetEGTPQci9

::IxLoad delete $my_ixNetEGTPQci10

::IxLoad delete $my_ixNetEGTPPluginPortGroupData

::IxLoad delete $my_ixNetSM_DNSPluginPortGroupData

::IxLoad delete $testController


#################################################
# Disconnect / Release application lock
#################################################
}] {
	$logger error $errorInfo
	puts $errorInfo
}

::IxLoad disconnect
