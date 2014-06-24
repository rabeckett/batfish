parser grammar CiscoGrammar;

import
CiscoGrammarCommonParser, CiscoGrammar_acl, CiscoGrammar_bgp, CiscoGrammar_interface, CiscoGrammar_ospf, CiscoGrammar_routemap;

options {
	tokenVocab = CiscoGrammarCommonLexer;
}

@header {
package batfish.grammar.cisco;
import batfish.util.SubRange;
}

address_family_vrf_stanza
:
	ADDRESS_FAMILY ~NEWLINE* NEWLINE null_block_substanza* EXIT_ADDRESS_FAMILY
	NEWLINE closing_comment
;

banner_stanza
:
	BANNER MOTD ESCAPE_C .*? ESCAPE_C NEWLINE
;

certificate_stanza
:
	CERTIFICATE ~NEWLINE* NEWLINE
	(
		(
			DEC
			| REMOVED
			| VARIABLE
		) ~NEWLINE* NEWLINE
	)+ QUIT NEWLINE
;

cisco_configuration
:
	(
		sl += stanza
	)+ COLON? END
;

hostname_stanza
:
	HOSTNAME name = VARIABLE NEWLINE
;

ip_default_gateway_stanza
:
	IP DEFAULT_GATEWAY gateway = IP_ADDRESS
;

ip_route_stanza
:
	IP ROUTE prefix = IP_ADDRESS mask = IP_ADDRESS
	(
		nexthopip = IP_ADDRESS
		| nexthopint = interface_name
	)
	(
		distance = integer
	)?
	(
		TAG DEC
	)? PERMANENT?
	(
		TRACK DEC
	)? NEWLINE
;

macro_stanza
:
	MACRO ~COMMENT_CLOSING_LINE* closing_comment
;

null_block_stanza
:
	(
		ARCHIVE
		| CONTROL_PLANE
		| CONTROLLER
		| DIAL_PEER
		|
		(
			FLOW
			(
				EXPORTER
				| MONITOR
				| RECORD
			)
		)
		| GATEWAY
		| GROUP_POLICY
		| IPC
		|
		(
			IPV6 ACCESS_LIST
		)
		| LINE
		| POLICY_MAP
		| REDUNDANCY
		|
		(
			SCCP CCM GROUP
		)
		|
		(
			STCAPP
			(
				FEATURE
				| SUPPLEMENTARY_SERVICES
			)
		)
		|
		(
			VLAN DEC
		)
		| VOICE
		| VOICE_PORT
		| VPDN_GROUP
	) ~NEWLINE* NEWLINE null_block_substanza*
	(
		closing_comment
	)
;

null_block_substanza
:
	comment_stanza
	|
	(
		NO?
		(
			ABSOLUTE_TIMEOUT
			| ACCEPT_DIALIN
			| ACCESS_CLASS
			| ACCOUNTING_SERVER_GROUP
			| ACTIVATION_CHARACTER
			| ADDRESS_POOL
			| ANYCONNECT
			| ASSOCIATE
			| ASSOCIATION
			| AUTHENTICATION
			| AUTHENTICATION_SERVER_GROUP
			| AUTHORIZATION
			| AUTHORIZATION_REQUIRED
			| AUTHORIZATION_SERVER_GROUP
			| AUTO_SYNC
			| AUTOSELECT
			| BANDWIDTH
			| BANNER
			| BIND
			| BRIDGE
			| CABLELENGTH
			| CACHE
			| CALL
			| CALLER_ID
			| CAS_CUSTOM
			| CERTIFICATE
			| CLASS
			| CLOCK
			| COLLECT
			| CONFORM_ACTION
			| CPTONE
			| CRL
			| CRYPTO
			| DBL
			| DEFAULT_DOMAIN
			| DEFAULT_GROUP_POLICY
			| DENY
			| DESCRIPTION
			| DESTINATION
			| DIAGNOSTIC
			| DNS_SERVER
			| DS0_GROUP
			| ENROLLMENT
			| EXCEED_ACTION
			| EXEC
			| EXEC_TIMEOUT
			| EXPORT_PROTOCOL
			| EXPORTER
			| FABRIC
			| FALLBACK_DN
			| FILE_BROWSING
			| FILE_ENTRY
			| FQDN
			| FRAMING
			| GROUP_ALIAS
			| GROUP_POLICY
			| GROUP_URL
			| HIDDEN_SHARES
			| HIDEKEYS
			| HISTORY
			| INSPECT
			| IP
			| IPSEC_UDP
			| IPV6
			| IPV6_ADDRESS_POOL
			| ISAKMP
			| KEEPALIVE_ENABLE
			| KEYPAIR
			| L2TP
			| LINE
			| LINECODE
			| LLDP
			| LOCAL_IP
			| LOCAL_PORT
			| LOCATION
			| LOG
			| LOGGING
			| LOGIN
			| MAIN_CPU
			| MATCH
			| MESSAGE_LENGTH
			| MODE
			| MODEM
			| MTU
			| NAME
			| NOTIFY
			| PARAMETERS
			| PARENT
			| PASSWORD_STORAGE
			| PERMIT
			| PICKUP
			| POLICE
			| POLICY_MAP
			| PORT
			| PREFIX
			| PRI_GROUP
			| PRIORITY
			| PRIVILEGE
			| PROTOCOL
			| QUEUE_BUFFERS
			| QUEUE_LIMIT
			| RD
			| RECORD
			| RECORD_ENTRY
			| REMARK
			| REMOTE_IP
			| REMOTE_PORT
			| REMOTE_SPAN
			| REMOVED
			| RING
			| SCHEME
			| SERVICE
			| SERVICE_POLICY
			| SERVICE_TYPE
			| SESSION_LIMIT
			| SESSION_TIMEOUT
			| SET
			| SHUTDOWN
			| SOURCE
			| SPANNING_TREE
			| SPEED
			| SPLIT_TUNNEL_NETWORK_LIST
			| SPLIT_TUNNEL_POLICY
			| STOPBITS
			| STP
			| SUBJECT_NAME
			| SWITCHBACK
			| TB_VLAN1
			| TB_VLAN2
			| TERMINAL_TYPE
			| TIMEOUTS
			| TIMER
			| TIMING
			| TRANSPORT
			| TUNNEL_GROUP
			| VIOLATE_ACTION
			| VIRTUAL_TEMPLATE
			| VPN_FILTER
			| VPN_IDLE_TIMEOUT
			| VPN_TUNNEL_PROTOCOL
			| WEBVPN
			| WINS_SERVER
			| WITHOUT_CSD
		)
		(
			remaining_tokens += ~NEWLINE
		)* NEWLINE
	)
;

null_standalone_stanza
:
	(
		NO
	)?
	(
		AAA
		| AAA_SERVER
		| ACCESS_GROUP
		|
		(
			ACCESS_LIST
			(
				(
					DEC REMARK
				)
				| VARIABLE
			)
		)
		| ACCOUNTING_PORT
		| ACTION
		| ACTIVE
		| ADDRESS
		| ALERT_GROUP
		| ALIAS
		| ANYCONNECT
		| ANYCONNECT_ESSENTIALS
		| AP
		| ARP
		| ASA
		| ASDM
		| ASSOCIATE
		| ASYNC_BOOTP
		| AUTHENTICATION
		| AUTHENTICATION_PORT
		| AUTO
		| BOOT
		| BOOT_END_MARKER
		| BOOT_START_MARKER
		| CALL
		| CALL_HOME
		| CARD
		| CCM_MANAGER
		| CDP
		| CIPC
		| CLASS_MAP
		| CLOCK
		| CLUSTER
		| CNS
		| CODEC
		| CONFIG_REGISTER
		| CONSOLE
		| CONTACT_EMAIL_ADDR
		| CRL
		| CRYPTO
		| CTL_FILE
		| CTS
		| DEFAULT
		| DESCRIPTION
		| DESTINATION
		| DEVICE_SENSOR
		| DHCPD
		| DIAGNOSTIC
		| DIALER_LIST
		| DISABLE
		| DNS
		| DNS_GUARD
		| DOMAIN_NAME
		| DOT11
		| DSP
		| DSPFARM
		| DYNAMIC_ACCESS_POLICY_RECORD
		| ENABLE
		| ENCR
		| ENCRYPTION
		| ENROLLMENT
		| ENVIRONMENT
		| ERRDISABLE
		| EVENT
		| EXCEPTION
		| FABRIC
		| FAILOVER
		| FILE
		| FIREWALL
		| FIRMWARE
		| FQDN
		| FTP
		| FTP_SERVER
		| GATEKEEPER
		| GROUP
		| GROUP_OBJECT
		| HASH
		| HOST
		| HTTP
		| HW_MODULE
		| ICMP
		| ICMP_ECHO
		| ICMP_OBJECT
		| IDENTITY
		| INACTIVITY_TIMER
		|
		(
			IP
			(
				ADDRESS_POOL
				| ADMISSION
				| ALIAS
				| ARP
				| AUDIT
				| AUTH_PROXY
				| BOOTP
				| BGP_COMMUNITY
				| CEF
				| CLASSLESS
				| DEFAULT_NETWORK
				| DEVICE
				| DHCP
				| DOMAIN
				| DOMAIN_LIST
				| DOMAIN_LOOKUP
				| DOMAIN_NAME
				| FINGER
				| FLOW_CACHE
				| FLOW_EXPORT
				| FORWARD_PROTOCOL
				| FTP
				| GRATUITOUS_ARPS
				| HOST_ROUTING
				| HTTP
				| IGMP
				| LOCAL
				| MFIB
				| MROUTE
				| MSDP
				| MULTICAST
				| MULTICAST_ROUTING
				| NAME_SERVER
				| NAT
				|
				(
					OSPF NAME_LOOKUP
				)
				|
				(
					PREFIX_LIST VARIABLE
					(
						SEQ DEC
					)? DESCRIPTION
				)
				| PIM
				| RADIUS
				| RCMD
				|
				(
					ROUTE VRF
				)
				| ROUTING //might want to use this eventually

				| SAP
				| SCP
				| SLA
				| SOURCE_ROUTE
				| SSH
				| SUBNET_ZERO
				| TACACS
				| TCP
				| TELNET
				| TFTP
				| VERIFY
				| VRF
			)
		)
		| IP_ADDRESS_LITERAL
		|
		(
			IPV6
			(
				CEF
				| HOST
				| LOCAL
				| MFIB
				| MLD
				| MULTICAST
				| MULTICAST_ROUTING
				| ND
				|
				(
					OSPF NAME_LOOKUP
				)
				| PIM
				| PREFIX_LIST
				| ROUTE
				| UNICAST_ROUTING
			)
		)
		| ISDN
		| KEEPOUT
		| KEYPAIR
		| LDAP_BASE_DN
		| LDAP_LOGIN
		| LDAP_LOGIN_DN
		| LDAP_NAMING_ATTRIBUTE
		| LDAP_SCOPE
		| LICENSE
		| LIFETIME
		| LLDP
		| LOGGING
		| MAC
		| MAC_ADDRESS_TABLE
		| MAIL_SERVER
		| MATCH
		| MAXIMUM
		| MEDIA_TERMINATION
		| MEMORY_SIZE
		| MGCP
		| MICROCODE
		| MLS
		| MODE
		| MODEM
		| MONITOR
		| MPLS
		| MTA
		| MTU
		| MULTILINK
		| NAME_SERVER
		| NAME
		| NAMES
		| NAT
		| NAT_CONTROL
		| NETWORK_OBJECT
		| NETWORK_CLOCK_PARTICIPATE
		| NETWORK_CLOCK_SELECT
		| NTP
		| OBJECT
		| OBJECT_GROUP
		| PAGER
		| PARTICIPATE
		| PERCENT
		| PHONE_PROXY
		| PLATFORM
		| PORT_OBJECT
		| POWER
		| PRIORITY
		| PRIORITY_QUEUE
		| PRIVILEGE
		| PROCESS
		| PROFILE
		| PROMPT
		| PROTOCOL_OBJECT
		| QOS
		| RADIUS_COMMON_PW
		| RADIUS_SERVER
		| RD
		| RECORD_ENTRY
		| REDIRECT_FQDN
		| RESOURCE
		| RESOURCE_POOL
		| REVOCATION_CHECK
		| ROUTE
		| RSAKEYPAIR
		| RTR
		| SAME_SECURITY_TRAFFIC
		|
		(
			SCCP
			(
				(
					CCM IP_ADDRESS
				)
				| LOCAL
			)
		)
		| SCHEDULER
		| SCRIPTING
		| SECURITY
		| SENDER
		| SERIAL_NUMBER
		| SERVER
		| SERVER_TYPE
		| SERVICE
		| SERVICE_POLICY
		| SET
		| SHELL
		| SHUTDOWN
		| SMTP_SERVER
		| SNMP
		| SNMP_SERVER
		| SOURCE
		| SOURCE_INTERFACE
		| SOURCE_IP_ADDRESS
		| SPANNING_TREE
		| SPE
		| SSH
		| SSL
		| STATIC
		|
		(
			STCAPP
			(
				CCM_GROUP
			)
		)
		| SUBJECT_NAME
		| SUBNET
		| SUBSCRIBE_TO
		| SUBSCRIBE_TO_ALERT_GROUP
		| SWITCH
		| SYSOPT
		| SYSTEM
		| TABLE_MAP
		| TAG_SWITCHING
		| TELNET
		| TFTP_SERVER
		| THREAT_DETECTION
		| TIMEOUT
		| TLS_PROXY
		| TRACK
		| TRANSLATE
		| TRANSPORT
		| TUNNEL_GROUP_LIST
		| TYPE
		| UDLD
		| UNABLE
		| UPGRADE
		| USER_IDENTITY
		| USERNAME
		| VALIDATION_USAGE
		| VERSION
		|
		(
			VLAN
			(
				ACCESS_LOG
				| DOT1Q
				| INTERNAL
			)
		)
		| VMPS
		| VPDN
		| VPN
		| VTP
		| VOICE_CARD
		| WEBVPN
		| WSMA
		| X25
		| X29
		| XLATE
	)
	(
		remaining_tokens += ~NEWLINE
	)* NEWLINE
;

null_stanza
:
	banner_stanza
	| certificate_stanza
	| closing_comment
	| comment_stanza
	| macro_stanza
	| null_block_stanza
	| null_standalone_stanza
	|
	(
		(
			| SCCP
			| STCAPP
		) NEWLINE
	)
	| vrf_stanza
;

stanza
:
	access_list_stanza
	| hostname_stanza
	| interface_stanza
	| ip_access_list_extended_stanza
	| ip_access_list_standard_stanza
	| ip_as_path_access_list_stanza
	| ip_community_list_stanza
	| ip_default_gateway_stanza
	| ip_prefix_list_line_stanza
	| ip_route_stanza
	| ipv6_router_ospf_stanza
	| null_stanza
	| route_map_stanza
	| router_bgp_stanza
	| router_ospf_stanza
;

vrf_stanza
:
	VRF ~NEWLINE* NEWLINE null_block_substanza* closing_comment
	address_family_vrf_stanza*
;
