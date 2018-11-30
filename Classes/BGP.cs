using System;
using System.Management.Automation;

namespace OPNsense.quagga.bgp.aspaths {
	public class Aspath {
		#region Parameters
		public PSObject action { get; set; }
		public string AS { get; set; }
		public bool enabled { get; set; }
		public byte number { get; set; }
		#endregion Parameters

		public Aspath () {
			action = null;
			AS = null;
			enabled = true;
			number = 0;
		}

		public Aspath (
			PSObject Action,
			string AS_,
			byte Enabled,
			byte Number
		) {
			action = Action;
			AS = AS_;
			enabled = (Enabled == 0) ? false : true;
			number = Number;
		}
	}
}
namespace OPNsense.quagga.bgp.neighbors {
	public class Neighbor {
		#region Parameters
		public PSObject address { get; set; }
		public bool defaultoriginate { get; set; }
		public bool enabled { get; set; }
		public PSObject linkedPrefixlistIn { get; set; }
		public PSObject linkedPrefixlistOut { get; set; }
		public PSObject linkedRoutemapIn { get; set; }
		public PSObject linkedRoutemapOut { get; set; }
		public bool nexthopself { get; set; }
		public uint remoteas { get; set; }
		public PSObject updatesource { get; set; }
		#endregion Parameters

		public Neighbor () {
			address = null;
			defaultoriginate = true;
			enabled = true;
			linkedPrefixlistIn = null;
			linkedPrefixlistOut = null;
			linkedRoutemapIn = null;
			linkedRoutemapOut = null;
			nexthopself = true;
			remoteas = 0;
			updatesource = null;
		}

		public Neighbor (
			PSObject Address,
			byte Defaultoriginate,
			byte Enabled,
			PSObject LinkedPrefixlistIn,
			PSObject LinkedPrefixlistOut,
			PSObject LinkedRoutemapIn,
			PSObject LinkedRoutemapOut,
			byte Nexthopself,
			uint Remoteas,
			PSObject Updatesource
		) {
			address = Address;
			defaultoriginate = (Defaultoriginate == 0) ? false : true;
			enabled = (Enabled == 0) ? false : true;
			linkedPrefixlistIn = LinkedPrefixlistIn;
			linkedPrefixlistOut = LinkedPrefixlistOut;
			linkedRoutemapIn = LinkedRoutemapIn;
			linkedRoutemapOut = LinkedRoutemapOut;
			nexthopself = (Nexthopself == 0) ? false : true;
			remoteas = Remoteas;
			updatesource = Updatesource;
		}
	}
}
namespace OPNsense.quagga.bgp.prefixlists {
	public class Prefixlist {
		#region Parameters
		public PSObject action { get; set; }
		public bool enabled { get; set; }
		public string name { get; set; }
		public string network { get; set; }
		public byte seqnumber { get; set; }
		public PSObject version { get; set; }
		#endregion Parameters

		public Prefixlist () {
			action = null;
			enabled = true;
			name = null;
			network = null;
			seqnumber = 0;
			version = null;
		}

		public Prefixlist (
			PSObject Action,
			byte Enabled,
			string Name,
			string Network,
			byte Seqnumber,
			PSObject Version
		) {
			action = Action;
			enabled = (Enabled == 0) ? false : true;
			name = Name;
			network = Network;
			seqnumber = Seqnumber;
			version = Version;
		}
	}
}
namespace OPNsense.quagga.bgp.routemaps {
	public class Routemap {
		#region Parameters
		public PSObject action { get; set; }
		public bool enabled { get; set; }
		public byte id { get; set; }
		public PSObject match { get; set; }
		public string name { get; set; }
		public string set { get; set; }
		#endregion Parameters

		public Routemap () {
			action = null;
			enabled = true;
			id = 0;
			match = null;
			name = null;
			set = null;
		}

		public Routemap (
			PSObject Action,
			byte Enabled,
			byte Id,
			PSObject Match,
			string Name,
			string Set
		) {
			action = Action;
			enabled = (Enabled == 0) ? false : true;
			id = Id;
			match = Match;
			name = Name;
			set = Set;
		}
	}
}
namespace OPNsense.quagga {
	public class General {
		#region Parameters
		public bool enablecarp { get; set; }
		public bool enabled { get; set; }
		public bool enablelogfile { get; set; }
		public bool enablesyslog { get; set; }
		public PSObject logfilelevel { get; set; }
		public PSObject sysloglevel { get; set; }
		#endregion Parameters

		public General () {
			enablecarp = true;
			enabled = true;
			enablelogfile = true;
			enablesyslog = true;
			logfilelevel = null;
			sysloglevel = null;
		}

		public General (
			byte Enablecarp,
			byte Enabled,
			byte Enablelogfile,
			byte Enablesyslog,
			PSObject Logfilelevel,
			PSObject Sysloglevel
		) {
			enablecarp = (Enablecarp == 0) ? false : true;
			enabled = (Enabled == 0) ? false : true;
			enablelogfile = (Enablelogfile == 0) ? false : true;
			enablesyslog = (Enablesyslog == 0) ? false : true;
			logfilelevel = Logfilelevel;
			sysloglevel = Sysloglevel;
		}
	}
}
namespace OPNsense.quagga {
	public class Bgp {
		#region Parameters
		public uint asnumber { get; set; }
		public bool enabled { get; set; }
		public Object networks { get; set; }
		public PSObject redistribute { get; set; }
		#endregion Parameters

		public Bgp () {
			asnumber = 0;
			enabled = true;
			networks = null;
			redistribute = null;
		}

		public Bgp (
			uint Asnumber,
			byte Enabled,
			Object Networks,
			PSObject Redistribute
		) {
			asnumber = Asnumber;
			enabled = (Enabled == 0) ? false : true;
			networks = Networks;
			redistribute = Redistribute;
		}
	}
}
