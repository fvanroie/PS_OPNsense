using System;
using System.Management.Automation;

namespace OPNsense.ProxyUserACL.general.ACLs {
	public class ACL {
		#region Parameters
		public PSObject Black { get; set; }
		public Object Domains { get; set; }
		public PSObject Group { get; set; }
		public string Hex { get; set; }
		public string Name { get; set; }
		public int Priority { get; set; }
		#endregion Parameters

		public ACL () {
			Black = null;
			Domains = null;
			Group = null;
			Hex = null;
			Name = null;
			Priority = 0;
		}

		public ACL (
			PSObject black,
			Object domains,
			PSObject group,
			string hex,
			string name,
			int priority
		) {
			Black = black;
			Domains = domains;
			Group = group;
			Hex = hex;
			Name = name;
			Priority = priority;
		}
	}
}
