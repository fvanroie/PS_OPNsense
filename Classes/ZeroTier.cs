namespace OPNsense.ZeroTier {
	public class Network {
		#region Paramaters
		public string description { get; set; }
		public bool enabled { get; set; }
		public string networkId { get; set; }
		#endregion Paramaters

		#region Constructors
		public Network() {
			description = null;
			enabled = false;
			networkId = null;
		}

		public Network(
			string Description,
			bool Enabled,
			string NetworkId
		) {
			description = Description;
			enabled = Enabled;
			networkId = NetworkId;
		}
		#endregion Constructors
	}
}
