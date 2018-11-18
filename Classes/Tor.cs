using System;
using System.Management.Automation;

namespace OPNsense.tor.general.client_authentications {
	public class Client_Auth {
		#region Parameters
		public string auth_cookie { get; set; }
		public bool enabled { get; set; }
		public string onion_service { get; set; }
		#endregion Parameters

		public Client_Auth () {
			auth_cookie = "0000000000000000000000";
			enabled = true;
			onion_service = "exampleexample23.onion";
		}

		public Client_Auth (
			string Auth_Cookie,
			byte Enabled,
			string Onion_Service
		) {
			auth_cookie = Auth_Cookie;
			enabled = (Enabled == 0) ? false : true;
			onion_service = Onion_Service;
		}
	}
}
namespace OPNsense.tor.exitpolicy {
	public class Policy {
		#region Parameters
		public PSObject action { get; set; }
		public bool enabled { get; set; }
		public ushort endport { get; set; }
		public PSObject network { get; set; }
		public ushort startport { get; set; }
		public PSObject type { get; set; }
		#endregion Parameters

		public Policy () {
			action = null;
			enabled = true;
			endport = 0;
			network = null;
			startport = 0;
			type = null;
		}

		public Policy (
			PSObject Action,
			byte Enabled,
			ushort Endport,
			PSObject Network,
			ushort Startport,
			PSObject Type
		) {
			action = Action;
			enabled = (Enabled == 0) ? false : true;
			endport = Endport;
			network = Network;
			startport = Startport;
			type = Type;
		}
	}
}
namespace OPNsense.tor.hiddenservice {
	public class Service {
		#region Parameters
		public Object clients { get; set; }
		public bool enabled { get; set; }
		public string name { get; set; }
		public PSObject type { get; set; }
		#endregion Parameters

		public Service () {
			clients = null;
			enabled = true;
			name = null;
			type = null;
		}

		public Service (
			Object Clients,
			byte Enabled,
			string Name,
			PSObject Type
		) {
			clients = Clients;
			enabled = (Enabled == 0) ? false : true;
			name = Name;
			type = Type;
		}
	}
}
namespace OPNsense.tor.hiddenserviceacl {
	public class Hiddenserviceacl {
		#region Parameters
		public bool enabled { get; set; }
		public PSObject hiddenservice { get; set; }
		public ushort port { get; set; }
		public PSObject target_host { get; set; }
		public ushort target_port { get; set; }
		#endregion Parameters

		public Hiddenserviceacl () {
			enabled = true;
			hiddenservice = null;
			port = 80;
			target_host = null;
			target_port = 80;
		}

		public Hiddenserviceacl (
			byte Enabled,
			PSObject Hiddenservice,
			ushort Port,
			PSObject Target_Host,
			ushort Target_Port
		) {
			enabled = (Enabled == 0) ? false : true;
			hiddenservice = Hiddenservice;
			port = Port;
			target_host = Target_Host;
			target_port = Target_Port;
		}
	}
}
namespace OPNsense.tor.aclsockspolicy {
	public class Policy {
		#region Parameters
		public PSObject action { get; set; }
		public bool enabled { get; set; }
		public PSObject network { get; set; }
		public PSObject type { get; set; }
		#endregion Parameters

		public Policy () {
			action = null;
			enabled = true;
			network = null;
			type = null;
		}

		public Policy (
			PSObject Action,
			byte Enabled,
			PSObject Network,
			PSObject Type
		) {
			action = Action;
			enabled = (Enabled == 0) ? false : true;
			network = Network;
			type = Type;
		}
	}
}
namespace OPNsense.tor {
	public class General {
		#region Parameters
		public ushort control_port { get; set; }
		public string control_port_password { get; set; }
		public string control_port_password_hashed { get; set; }
		public bool dns_map_hosts { get; set; }
		public bool enabled { get; set; }
		public bool enablelogfile { get; set; }
		public bool enablesyslog { get; set; }
		public bool enable_transparent { get; set; }
		public bool fascist_firewall { get; set; }
		public Object fascist_firewall_ports { get; set; }
		public PSObject logfilelevel { get; set; }
		public uint max_memory_in_queues { get; set; }
		public PSObject scheduler { get; set; }
		public PSObject socks_listen_ip { get; set; }
		public ushort socks_listen_port { get; set; }
		public PSObject sysloglevel { get; set; }
		public ushort transparent_dns { get; set; }
		public PSObject transparent_ip_pool { get; set; }
		public ushort transparent_port { get; set; }
		#endregion Parameters

		public General () {
			control_port = 9051;
			control_port_password = null;
			control_port_password_hashed = null;
			dns_map_hosts = true;
			enabled = true;
			enablelogfile = true;
			enablesyslog = true;
			enable_transparent = true;
			fascist_firewall = true;
			fascist_firewall_ports = null;
			logfilelevel = null;
			max_memory_in_queues = 0;
			scheduler = null;
			socks_listen_ip = null;
			socks_listen_port = 9050;
			sysloglevel = null;
			transparent_dns = 9053;
			transparent_ip_pool = null;
			transparent_port = 9040;
		}

		public General (
			ushort Control_Port,
			string Control_Port_Password,
			string Control_Port_Password_Hashed,
			byte Dns_Map_Hosts,
			byte Enabled,
			byte Enablelogfile,
			byte Enablesyslog,
			byte Enable_Transparent,
			byte Fascist_Firewall,
			Object Fascist_Firewall_Ports,
			PSObject Logfilelevel,
			uint Max_Memory_In_Queues,
			PSObject Scheduler,
			PSObject Socks_Listen_Ip,
			ushort Socks_Listen_Port,
			PSObject Sysloglevel,
			ushort Transparent_Dns,
			PSObject Transparent_Ip_Pool,
			ushort Transparent_Port
		) {
			control_port = Control_Port;
			control_port_password = Control_Port_Password;
			control_port_password_hashed = Control_Port_Password_Hashed;
			dns_map_hosts = (Dns_Map_Hosts == 0) ? false : true;
			enabled = (Enabled == 0) ? false : true;
			enablelogfile = (Enablelogfile == 0) ? false : true;
			enablesyslog = (Enablesyslog == 0) ? false : true;
			enable_transparent = (Enable_Transparent == 0) ? false : true;
			fascist_firewall = (Fascist_Firewall == 0) ? false : true;
			fascist_firewall_ports = Fascist_Firewall_Ports;
			logfilelevel = Logfilelevel;
			max_memory_in_queues = Max_Memory_In_Queues;
			scheduler = Scheduler;
			socks_listen_ip = Socks_Listen_Ip;
			socks_listen_port = Socks_Listen_Port;
			sysloglevel = Sysloglevel;
			transparent_dns = Transparent_Dns;
			transparent_ip_pool = Transparent_Ip_Pool;
			transparent_port = Transparent_Port;
		}
	}
}
namespace OPNsense.tor {
	public class Relay {
		#region Parameters
		public string address { get; set; }
		public int bandwithburst { get; set; }
		public int bandwithrate { get; set; }
		public string contact_info { get; set; }
		public ushort directory_port { get; set; }
		public bool dir_frontpage { get; set; }
		public bool enabled { get; set; }
		public bool exitenabled { get; set; }
		public bool exitipv6 { get; set; }
		public bool exitrejectlocalif { get; set; }
		public bool exitrejectprivateip { get; set; }
		public string host { get; set; }
		public string hostv6 { get; set; }
		public string nick { get; set; }
		public string outboundbind { get; set; }
		public string outboundbindv6 { get; set; }
		public ushort port { get; set; }
		public bool publish { get; set; }
		public bool relay { get; set; }
		#endregion Parameters

		public Relay () {
			address = null;
			bandwithburst = 0;
			bandwithrate = 0;
			contact_info = null;
			directory_port = 0;
			dir_frontpage = true;
			enabled = true;
			exitenabled = true;
			exitipv6 = true;
			exitrejectlocalif = true;
			exitrejectprivateip = true;
			host = null;
			hostv6 = null;
			nick = null;
			outboundbind = null;
			outboundbindv6 = null;
			port = 9001;
			publish = true;
			relay = true;
		}

		public Relay (
			string Address,
			int Bandwithburst,
			int Bandwithrate,
			string Contact_Info,
			ushort Directory_Port,
			byte Dir_Frontpage,
			byte Enabled,
			byte Exitenabled,
			byte Exitipv6,
			byte Exitrejectlocalif,
			byte Exitrejectprivateip,
			string Host,
			string Hostv6,
			string Nick,
			string Outboundbind,
			string Outboundbindv6,
			ushort Port,
			byte Publish,
			byte Relay
		) {
			address = Address;
			bandwithburst = Bandwithburst;
			bandwithrate = Bandwithrate;
			contact_info = Contact_Info;
			directory_port = Directory_Port;
			dir_frontpage = (Dir_Frontpage == 0) ? false : true;
			enabled = (Enabled == 0) ? false : true;
			exitenabled = (Exitenabled == 0) ? false : true;
			exitipv6 = (Exitipv6 == 0) ? false : true;
			exitrejectlocalif = (Exitrejectlocalif == 0) ? false : true;
			exitrejectprivateip = (Exitrejectprivateip == 0) ? false : true;
			host = Host;
			hostv6 = Hostv6;
			nick = Nick;
			outboundbind = Outboundbind;
			outboundbindv6 = Outboundbindv6;
			port = Port;
			publish = (Publish == 0) ? false : true;
			relay = (Relay == 0) ? false : true;
		}
	}
}
