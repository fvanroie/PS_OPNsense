using System;
using System.Management.Automation;

namespace OPNsense.helloworld {
	public class General {
		#region Parameters
		public string Description { get; set; }
		public bool Enabled { get; set; }
		public string FromEmail { get; set; }
		public PSObject SMTPHost { get; set; }
		public string ToEmail { get; set; }
		#endregion Parameters

		public General () {
			Description = null;
			Enabled = true;
			FromEmail = "sample@example.com";
			SMTPHost = null;
			ToEmail = null;
		}

		public General (
			string description,
			byte enabled,
			string fromemail,
			PSObject smtphost,
			string toemail
		) {
			Description = description;
			Enabled = (enabled == 0) ? false : true;
			FromEmail = fromemail;
			SMTPHost = smtphost;
			ToEmail = toemail;
		}
	}
}
