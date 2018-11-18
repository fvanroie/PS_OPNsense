using System;
using System.Management.Automation;

namespace OPNsense {
	public class Bind {
		#region Parameters
		public  dnsbl { get; set; }
		#endregion Parameters

		public Bind () {
			dnsbl = ;
		}

		public Bind (
			 Dnsbl
		) {
			dnsbl = Dnsbl;
		}
	}
}
namespace OPNsense.bind.acl.acls {
	public class Acl {
		#region Parameters
		public bool enabled { get; set; }
		public string name { get; set; }
		public PSObject networks { get; set; }
		#endregion Parameters

		public Acl () {
			enabled = true;
			name = null;
			networks = null;
		}

		public Acl (
			byte Enabled,
			string Name,
			PSObject Networks
		) {
			enabled = (Enabled == 0) ? false : true;
			name = Name;
			networks = Networks;
		}
	}
}
namespace OPNsense.bind {
	public class General {
		#region Parameters
		public PSObject dnssecvalidation { get; set; }
		public bool enabled { get; set; }
		public PSObject forwarders { get; set; }
		public PSObject listenv4 { get; set; }
		public PSObject listenv6 { get; set; }
		public ushort logsize { get; set; }
		public byte maxcachesize { get; set; }
		public PSObject port { get; set; }
		public PSObject recursion { get; set; }
		#endregion Parameters

		public General () {
			dnssecvalidation = null;
			enabled = true;
			forwarders = null;
			listenv4 = null;
			listenv6 = null;
			logsize = 5;
			maxcachesize = 80;
			port = null;
			recursion = null;
		}

		public General (
			PSObject Dnssecvalidation,
			byte Enabled,
			PSObject Forwarders,
			PSObject Listenv4,
			PSObject Listenv6,
			ushort Logsize,
			byte Maxcachesize,
			PSObject Port,
			PSObject Recursion
		) {
			dnssecvalidation = Dnssecvalidation;
			enabled = (Enabled == 0) ? false : true;
			forwarders = Forwarders;
			listenv4 = Listenv4;
			listenv6 = Listenv6;
			logsize = Logsize;
			maxcachesize = Maxcachesize;
			port = Port;
			recursion = Recursion;
		}
	}
}
