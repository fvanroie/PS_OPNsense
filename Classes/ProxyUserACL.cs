namespace OPNsense.ProxyUserACL {
	public class UserACL {
		#region Paramaters
		public System.Management.Automation.PSObject Black { get; set; }
		public System.Object[] Domains { get; set; }
		public System.Management.Automation.PSObject Group { get; set; }
		public string Hex { get; set; }
		public string Name { get; set; }
		public int Priority { get; set; }
		#endregion Paramaters

		#region Constructors
		public UserACL() {
			Black = null;
			Domains = null;
			Group = null;
			Hex = null;
			Name = null;
			Priority = 0;
		}

		public UserACL(
			System.Management.Automation.PSObject black,
			System.Object[] domains,
			System.Management.Automation.PSObject group,
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
		#endregion Constructors
	}
}
