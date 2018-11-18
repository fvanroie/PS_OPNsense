using System;
using System.Management.Automation;

namespace OPNsense.siproxd.domain.domains {
	public class Domain {
		#region Parameters
		public bool enabled { get; set; }
		public string host { get; set; }
		public string name { get; set; }
		public int port { get; set; }
		#endregion Parameters

		public Domain () {
			enabled = true;
			host = null;
			name = null;
			port = 5060;
		}

		public Domain (
			byte Enabled,
			string Host,
			string Name,
			int Port
		) {
			enabled = (Enabled == 0) ? false : true;
			host = Host;
			name = Name;
			port = Port;
		}
	}
}
namespace OPNsense.siproxd.user.users {
	public class User {
		#region Parameters
		public bool enabled { get; set; }
		public string password { get; set; }
		public string username { get; set; }
		#endregion Parameters

		public User () {
			enabled = true;
			password = null;
			username = null;
		}

		public User (
			byte Enabled,
			string Password,
			string Username
		) {
			enabled = (Enabled == 0) ? false : true;
			password = Password;
			username = Username;
		}
	}
}
namespace OPNsense.siproxd {
	public class General {
		#region Parameters
		public bool enabled { get; set; }
		public PSObject hosts_allow_reg { get; set; }
		public PSObject hosts_allow_sip { get; set; }
		public PSObject hosts_deny_sip { get; set; }
		public string host_outbound { get; set; }
		public PSObject if_inbound { get; set; }
		public PSObject if_outbound { get; set; }
		public bool plugin_defaulttarget_enable { get; set; }
		public bool plugin_defaulttarget_log { get; set; }
		public string plugin_defaulttarget_target { get; set; }
		public bool plugin_fbox_anoncall_enable { get; set; }
		public PSObject plugin_fbox_anoncall_networks { get; set; }
		public bool plugin_fix_bogus_via_enable { get; set; }
		public PSObject plugin_fix_bogus_via_networks { get; set; }
		public bool plugin_fix_DTAG_enable { get; set; }
		public PSObject plugin_fix_DTAG_networks { get; set; }
		public bool plugin_stun_server_enable { get; set; }
		public string plugin_stun_server_host { get; set; }
		public int plugin_stun_server_period { get; set; }
		public int plugin_stun_server_port { get; set; }
		public bool proxy_auth_enable { get; set; }
		public byte rtp_dscp { get; set; }
		public ushort rtp_input_dejitter { get; set; }
		public ushort rtp_output_dejitter { get; set; }
		public ushort rtp_port_high { get; set; }
		public ushort rtp_port_low { get; set; }
		public ushort rtp_timeout { get; set; }
		public byte sip_dscp { get; set; }
		public ushort sip_listen_port { get; set; }
		public ushort tcp_connect_timeout { get; set; }
		public ushort tcp_keepalive { get; set; }
		public ushort tcp_timeout { get; set; }
		public string ua_string { get; set; }
		public PSObject use_rport { get; set; }
		#endregion Parameters

		public General () {
			enabled = true;
			hosts_allow_reg = null;
			hosts_allow_sip = null;
			hosts_deny_sip = null;
			host_outbound = null;
			if_inbound = null;
			if_outbound = null;
			plugin_defaulttarget_enable = true;
			plugin_defaulttarget_log = true;
			plugin_defaulttarget_target = null;
			plugin_fbox_anoncall_enable = true;
			plugin_fbox_anoncall_networks = null;
			plugin_fix_bogus_via_enable = true;
			plugin_fix_bogus_via_networks = null;
			plugin_fix_DTAG_enable = true;
			plugin_fix_DTAG_networks = null;
			plugin_stun_server_enable = true;
			plugin_stun_server_host = null;
			plugin_stun_server_period = 0;
			plugin_stun_server_port = 0;
			proxy_auth_enable = true;
			rtp_dscp = 46;
			rtp_input_dejitter = 0;
			rtp_output_dejitter = 0;
			rtp_port_high = 7089;
			rtp_port_low = 7070;
			rtp_timeout = 300;
			sip_dscp = 0;
			sip_listen_port = 5060;
			tcp_connect_timeout = 500;
			tcp_keepalive = 20;
			tcp_timeout = 600;
			ua_string = null;
			use_rport = null;
		}

		public General (
			byte Enabled,
			PSObject Hosts_Allow_Reg,
			PSObject Hosts_Allow_Sip,
			PSObject Hosts_Deny_Sip,
			string Host_Outbound,
			PSObject If_Inbound,
			PSObject If_Outbound,
			byte Plugin_Defaulttarget_Enable,
			byte Plugin_Defaulttarget_Log,
			string Plugin_Defaulttarget_Target,
			byte Plugin_Fbox_Anoncall_Enable,
			PSObject Plugin_Fbox_Anoncall_Networks,
			byte Plugin_Fix_Bogus_Via_Enable,
			PSObject Plugin_Fix_Bogus_Via_Networks,
			byte Plugin_Fix_DTAG_Enable,
			PSObject Plugin_Fix_DTAG_Networks,
			byte Plugin_Stun_Server_Enable,
			string Plugin_Stun_Server_Host,
			int Plugin_Stun_Server_Period,
			int Plugin_Stun_Server_Port,
			byte Proxy_Auth_Enable,
			byte Rtp_Dscp,
			ushort Rtp_Input_Dejitter,
			ushort Rtp_Output_Dejitter,
			ushort Rtp_Port_High,
			ushort Rtp_Port_Low,
			ushort Rtp_Timeout,
			byte Sip_Dscp,
			ushort Sip_Listen_Port,
			ushort Tcp_Connect_Timeout,
			ushort Tcp_Keepalive,
			ushort Tcp_Timeout,
			string Ua_String,
			PSObject Use_Rport
		) {
			enabled = (Enabled == 0) ? false : true;
			hosts_allow_reg = Hosts_Allow_Reg;
			hosts_allow_sip = Hosts_Allow_Sip;
			hosts_deny_sip = Hosts_Deny_Sip;
			host_outbound = Host_Outbound;
			if_inbound = If_Inbound;
			if_outbound = If_Outbound;
			plugin_defaulttarget_enable = (Plugin_Defaulttarget_Enable == 0) ? false : true;
			plugin_defaulttarget_log = (Plugin_Defaulttarget_Log == 0) ? false : true;
			plugin_defaulttarget_target = Plugin_Defaulttarget_Target;
			plugin_fbox_anoncall_enable = (Plugin_Fbox_Anoncall_Enable == 0) ? false : true;
			plugin_fbox_anoncall_networks = Plugin_Fbox_Anoncall_Networks;
			plugin_fix_bogus_via_enable = (Plugin_Fix_Bogus_Via_Enable == 0) ? false : true;
			plugin_fix_bogus_via_networks = Plugin_Fix_Bogus_Via_Networks;
			plugin_fix_DTAG_enable = (Plugin_Fix_DTAG_Enable == 0) ? false : true;
			plugin_fix_DTAG_networks = Plugin_Fix_DTAG_Networks;
			plugin_stun_server_enable = (Plugin_Stun_Server_Enable == 0) ? false : true;
			plugin_stun_server_host = Plugin_Stun_Server_Host;
			plugin_stun_server_period = Plugin_Stun_Server_Period;
			plugin_stun_server_port = Plugin_Stun_Server_Port;
			proxy_auth_enable = (Proxy_Auth_Enable == 0) ? false : true;
			rtp_dscp = Rtp_Dscp;
			rtp_input_dejitter = Rtp_Input_Dejitter;
			rtp_output_dejitter = Rtp_Output_Dejitter;
			rtp_port_high = Rtp_Port_High;
			rtp_port_low = Rtp_Port_Low;
			rtp_timeout = Rtp_Timeout;
			sip_dscp = Sip_Dscp;
			sip_listen_port = Sip_Listen_Port;
			tcp_connect_timeout = Tcp_Connect_Timeout;
			tcp_keepalive = Tcp_Keepalive;
			tcp_timeout = Tcp_Timeout;
			ua_string = Ua_String;
			use_rport = Use_Rport;
		}
	}
}
