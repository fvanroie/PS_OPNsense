using System;
using System.Management.Automation;

namespace OPNsense.Nut {
	public class Account {
		#region Parameters
		public string admin_password { get; set; }
		public string mon_password { get; set; }
		#endregion Parameters

		public Account () {
			admin_password = "Password";
			mon_password = "Password";
		}

		public Account (
			string Admin_Password,
			string Mon_Password
		) {
			admin_password = Admin_Password;
			mon_password = Mon_Password;
		}
	}
}
namespace OPNsense.Nut {
	public class Apcsmart {
		#region Parameters
		public string args { get; set; }
		public bool enable { get; set; }
		#endregion Parameters

		public Apcsmart () {
			args = "port=auto";
			enable = true;
		}

		public Apcsmart (
			string Args,
			byte Enable
		) {
			args = Args;
			enable = (Enable == 0) ? false : true;
		}
	}
}
namespace OPNsense.Nut {
	public class Blazerusb {
		#region Parameters
		public string args { get; set; }
		public bool enable { get; set; }
		#endregion Parameters

		public Blazerusb () {
			args = "port=auto";
			enable = true;
		}

		public Blazerusb (
			string Args,
			byte Enable
		) {
			args = Args;
			enable = (Enable == 0) ? false : true;
		}
	}
}
namespace OPNsense.Nut {
	public class Netclient {
		#region Parameters
		public string address { get; set; }
		public bool enable { get; set; }
		public string password { get; set; }
		public string user { get; set; }
		#endregion Parameters

		public Netclient () {
			address = null;
			enable = true;
			password = null;
			user = null;
		}

		public Netclient (
			string Address,
			byte Enable,
			string Password,
			string User
		) {
			address = Address;
			enable = (Enable == 0) ? false : true;
			password = Password;
			user = User;
		}
	}
}
namespace OPNsense.Nut {
	public class Usbhid {
		#region Parameters
		public string args { get; set; }
		public bool enable { get; set; }
		#endregion Parameters

		public Usbhid () {
			args = "port=auto";
			enable = true;
		}

		public Usbhid (
			string Args,
			byte Enable
		) {
			args = Args;
			enable = (Enable == 0) ? false : true;
		}
	}
}
namespace OPNsense.Nut {
	public class General {
		#region Parameters
		public bool enable { get; set; }
		public PSObject mode { get; set; }
		public string name { get; set; }
		#endregion Parameters

		public General () {
			enable = true;
			mode = null;
			name = "UPSName";
		}

		public General (
			byte Enable,
			PSObject Mode,
			string Name
		) {
			enable = (Enable == 0) ? false : true;
			mode = Mode;
			name = Name;
		}
	}
}
