using System;
using System.Management.Automation;

namespace OPNsense.relayd {
	public class Host {
		#region Parameters
		public string address { get; set; }
		public uint ipTTL { get; set; }
		public string name { get; set; }
		public uint priority { get; set; }
		public uint retry { get; set; }
		#endregion Parameters

		public Host () {
			address = null;
			ipTTL = 0;
			name = null;
			priority = 0;
			retry = 0;
		}

		public Host (
			string Address,
			uint IpTTL,
			string Name,
			uint Priority,
			uint Retry
		) {
			address = Address;
			ipTTL = IpTTL;
			name = Name;
			priority = Priority;
			retry = Retry;
		}
	}
}
namespace OPNsense.relayd {
	public class Protocol {
		#region Parameters
		public string name { get; set; }
		public string options { get; set; }
		public PSObject type { get; set; }
		#endregion Parameters

		public Protocol () {
			name = null;
			options = null;
			type = null;
		}

		public Protocol (
			string Name,
			string Options,
			PSObject Type
		) {
			name = Name;
			options = Options;
			type = Type;
		}
	}
}
namespace OPNsense.relayd {
	public class Table {
		#region Parameters
		public bool enabled { get; set; }
		public PSObject hosts { get; set; }
		public string name { get; set; }
		#endregion Parameters

		public Table () {
			enabled = true;
			hosts = null;
			name = null;
		}

		public Table (
			byte Enabled,
			PSObject Hosts,
			string Name
		) {
			enabled = (Enabled == 0) ? false : true;
			hosts = Hosts;
			name = Name;
		}
	}
}
namespace OPNsense.relayd {
	public class Tablecheck {
		#region Parameters
		public int code { get; set; }
		public string data { get; set; }
		public string digest { get; set; }
		public string expect { get; set; }
		public string host { get; set; }
		public string name { get; set; }
		public string path { get; set; }
		public bool ssl { get; set; }
		public PSObject type { get; set; }
		#endregion Parameters

		public Tablecheck () {
			code = 0;
			data = null;
			digest = null;
			expect = null;
			host = null;
			name = null;
			path = null;
			ssl = false;
			type = null;
		}

		public Tablecheck (
			int Code,
			string Data,
			string Digest,
			string Expect,
			string Host,
			string Name,
			string Path,
			byte Ssl,
			PSObject Type
		) {
			code = Code;
			data = Data;
			digest = Digest;
			expect = Expect;
			host = Host;
			name = Name;
			path = Path;
			ssl = (Ssl == 0) ? false : true;
			type = Type;
		}
	}
}
namespace OPNsense.relayd {
	public class Virtualserver {
		#region Parameters
		public uint backuptransport_interval { get; set; }
		public PSObject backuptransport_table { get; set; }
		public PSObject backuptransport_tablecheck { get; set; }
		public PSObject backuptransport_tablemode { get; set; }
		public uint backuptransport_timeout { get; set; }
		public bool enabled { get; set; }
		public string listen_address { get; set; }
		public Nullable<ushort> listen_endport { get; set; }
		public PSObject listen_interface { get; set; }
		public Nullable<ushort> listen_startport { get; set; }
		public string name { get; set; }
		public PSObject protocol { get; set; }
		public PSObject routing_interface { get; set; }
		public uint sessiontimeout { get; set; }
		public bool stickyaddress { get; set; }
		public uint transport_interval { get; set; }
		public Nullable<ushort> transport_port { get; set; }
		public PSObject transport_table { get; set; }
		public PSObject transport_tablecheck { get; set; }
		public PSObject transport_tablemode { get; set; }
		public uint transport_timeout { get; set; }
		public PSObject transport_type { get; set; }
		public PSObject type { get; set; }
		#endregion Parameters

		public Virtualserver () {
			backuptransport_interval = 0;
			backuptransport_table = null;
			backuptransport_tablecheck = null;
			backuptransport_tablemode = null;
			backuptransport_timeout = 0;
			enabled = true;
			listen_address = null;
			listen_endport = null;
			listen_interface = null;
			listen_startport = null;
			name = null;
			protocol = null;
			routing_interface = null;
			sessiontimeout = 600;
			stickyaddress = true;
			transport_interval = 0;
			transport_port = null;
			transport_table = null;
			transport_tablecheck = null;
			transport_tablemode = null;
			transport_timeout = 0;
			transport_type = null;
			type = null;
		}

		public Virtualserver (
			uint Backuptransport_Interval,
			PSObject Backuptransport_Table,
			PSObject Backuptransport_Tablecheck,
			PSObject Backuptransport_Tablemode,
			uint Backuptransport_Timeout,
			byte Enabled,
			string Listen_Address,
			Nullable<ushort> Listen_Endport,
			PSObject Listen_Interface,
			Nullable<ushort> Listen_Startport,
			string Name,
			PSObject Protocol,
			PSObject Routing_Interface,
			uint Sessiontimeout,
			byte Stickyaddress,
			uint Transport_Interval,
			Nullable<ushort> Transport_Port,
			PSObject Transport_Table,
			PSObject Transport_Tablecheck,
			PSObject Transport_Tablemode,
			uint Transport_Timeout,
			PSObject Transport_Type,
			PSObject Type
		) {
			backuptransport_interval = Backuptransport_Interval;
			backuptransport_table = Backuptransport_Table;
			backuptransport_tablecheck = Backuptransport_Tablecheck;
			backuptransport_tablemode = Backuptransport_Tablemode;
			backuptransport_timeout = Backuptransport_Timeout;
			enabled = (Enabled == 0) ? false : true;
			listen_address = Listen_Address;
			listen_endport = Listen_Endport;
			listen_interface = Listen_Interface;
			listen_startport = Listen_Startport;
			name = Name;
			protocol = Protocol;
			routing_interface = Routing_Interface;
			sessiontimeout = Sessiontimeout;
			stickyaddress = (Stickyaddress == 0) ? false : true;
			transport_interval = Transport_Interval;
			transport_port = Transport_Port;
			transport_table = Transport_Table;
			transport_tablecheck = Transport_Tablecheck;
			transport_tablemode = Transport_Tablemode;
			transport_timeout = Transport_Timeout;
			transport_type = Transport_Type;
			type = Type;
		}
	}
}
namespace OPNsense.relayd {
	public class General {
		#region Parameters
		public bool enabled { get; set; }
		public uint interval { get; set; }
		public PSObject log { get; set; }
		public uint prefork { get; set; }
		public uint timeout { get; set; }
		#endregion Parameters

		public General () {
			enabled = true;
			interval = 10;
			log = null;
			prefork = 3;
			timeout = 200;
		}

		public General (
			byte Enabled,
			uint Interval,
			PSObject Log,
			uint Prefork,
			uint Timeout
		) {
			enabled = (Enabled == 0) ? false : true;
			interval = Interval;
			log = Log;
			prefork = Prefork;
			timeout = Timeout;
		}
	}
}
