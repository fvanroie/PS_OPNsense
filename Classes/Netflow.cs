using System;
using System.Management.Automation;

namespace OPNsense.Netflow {
	public class Capture {
		#region Parameters
		public PSObject egress_only { get; set; }
		public PSObject interfaces { get; set; }
		public Object targets { get; set; }
		public PSObject version { get; set; }
		#endregion Parameters

		public Capture () {
			egress_only = null;
			interfaces = null;
			targets = null;
			version = null;
		}

		public Capture (
			PSObject Egress_Only,
			PSObject Interfaces,
			Object Targets,
			PSObject Version
		) {
			egress_only = Egress_Only;
			interfaces = Interfaces;
			targets = Targets;
			version = Version;
		}
	}
}
namespace OPNsense.Netflow {
	public class Collect {
		#region Parameters
		public bool enable { get; set; }
		#endregion Parameters

		public Collect () {
			enable = true;
		}

		public Collect (
			byte Enable
		) {
			enable = (Enable == 0) ? false : true;
		}
	}
}
