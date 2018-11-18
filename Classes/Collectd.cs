using System;
using System.Management.Automation;

namespace OPNsense.collectd {
	public class General {
		#region Parameters
		public bool enabled { get; set; }
		public bool fqdnlookup { get; set; }
		public string hostname { get; set; }
		public int interval { get; set; }
		public bool p_contextswitch_enable { get; set; }
		public bool p_cpu_enable { get; set; }
		public bool p_df_enable { get; set; }
		public bool p_graphite_enable { get; set; }
		public string p_graphite_host { get; set; }
		public string p_graphite_node { get; set; }
		public ushort p_graphite_port { get; set; }
		public string p_graphite_postfix { get; set; }
		public string p_graphite_prefix { get; set; }
		public bool p_interface_enable { get; set; }
		public bool p_load_enable { get; set; }
		public bool p_memory_enable { get; set; }
		public bool p_network_enable { get; set; }
		public bool p_network_encryption { get; set; }
		public string p_network_host { get; set; }
		public string p_network_password { get; set; }
		public ushort p_network_port { get; set; }
		public string p_network_username { get; set; }
		public bool p_processes_enable { get; set; }
		public bool p_uptime_enable { get; set; }
		public bool p_users_enable { get; set; }
		#endregion Parameters

		public General () {
			enabled = true;
			fqdnlookup = true;
			hostname = null;
			interval = 10;
			p_contextswitch_enable = true;
			p_cpu_enable = true;
			p_df_enable = true;
			p_graphite_enable = true;
			p_graphite_host = null;
			p_graphite_node = null;
			p_graphite_port = 0;
			p_graphite_postfix = "collectd";
			p_graphite_prefix = "collectd";
			p_interface_enable = true;
			p_load_enable = true;
			p_memory_enable = true;
			p_network_enable = true;
			p_network_encryption = true;
			p_network_host = null;
			p_network_password = null;
			p_network_port = 0;
			p_network_username = null;
			p_processes_enable = true;
			p_uptime_enable = true;
			p_users_enable = true;
		}

		public General (
			byte Enabled,
			byte Fqdnlookup,
			string Hostname,
			int Interval,
			byte P_Contextswitch_Enable,
			byte P_Cpu_Enable,
			byte P_Df_Enable,
			byte P_Graphite_Enable,
			string P_Graphite_Host,
			string P_Graphite_Node,
			ushort P_Graphite_Port,
			string P_Graphite_Postfix,
			string P_Graphite_Prefix,
			byte P_Interface_Enable,
			byte P_Load_Enable,
			byte P_Memory_Enable,
			byte P_Network_Enable,
			byte P_Network_Encryption,
			string P_Network_Host,
			string P_Network_Password,
			ushort P_Network_Port,
			string P_Network_Username,
			byte P_Processes_Enable,
			byte P_Uptime_Enable,
			byte P_Users_Enable
		) {
			enabled = (Enabled == 0) ? false : true;
			fqdnlookup = (Fqdnlookup == 0) ? false : true;
			hostname = Hostname;
			interval = Interval;
			p_contextswitch_enable = (P_Contextswitch_Enable == 0) ? false : true;
			p_cpu_enable = (P_Cpu_Enable == 0) ? false : true;
			p_df_enable = (P_Df_Enable == 0) ? false : true;
			p_graphite_enable = (P_Graphite_Enable == 0) ? false : true;
			p_graphite_host = P_Graphite_Host;
			p_graphite_node = P_Graphite_Node;
			p_graphite_port = P_Graphite_Port;
			p_graphite_postfix = P_Graphite_Postfix;
			p_graphite_prefix = P_Graphite_Prefix;
			p_interface_enable = (P_Interface_Enable == 0) ? false : true;
			p_load_enable = (P_Load_Enable == 0) ? false : true;
			p_memory_enable = (P_Memory_Enable == 0) ? false : true;
			p_network_enable = (P_Network_Enable == 0) ? false : true;
			p_network_encryption = (P_Network_Encryption == 0) ? false : true;
			p_network_host = P_Network_Host;
			p_network_password = P_Network_Password;
			p_network_port = P_Network_Port;
			p_network_username = P_Network_Username;
			p_processes_enable = (P_Processes_Enable == 0) ? false : true;
			p_uptime_enable = (P_Uptime_Enable == 0) ? false : true;
			p_users_enable = (P_Users_Enable == 0) ? false : true;
		}
	}
}
