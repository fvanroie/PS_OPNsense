using System;
using System.Management.Automation;

namespace OPNsense.Firewall.Alias.aliases {
	public class Alias {
		#region Parameters
		public PSObject content { get; set; }
		public string description { get; set; }
		public bool enabled { get; set; }
		public PSObject name { get; set; }
		public PSObject proto { get; set; }
		public PSObject type { get; set; }
		public int updatefreq { get; set; }
		#endregion Parameters

		public Alias () {
			content = null;
			description = null;
			enabled = true;
			name = null;
			proto = null;
			type = null;
			updatefreq = 0;
		}

		public Alias (
			PSObject Content,
			string Description,
			byte Enabled,
			PSObject Name,
			PSObject Proto,
			PSObject Type,
			int Updatefreq
		) {
			content = Content;
			description = Description;
			enabled = (Enabled == 0) ? false : true;
			name = Name;
			proto = Proto;
			type = Type;
			updatefreq = Updatefreq;
		}
	}
}
