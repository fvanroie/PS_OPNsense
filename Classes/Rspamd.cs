using System;
using System.Management.Automation;

namespace OPNsense.Rspamd
{
    public class Rate_Limit
    {
        #region Parameters
        public uint max_rcpt { get; set; }
        public Object whitelisted_rcpts { get; set; }
        #endregion Parameters

        public Rate_Limit()
        {
            max_rcpt = 20;
            whitelisted_rcpts = null;
        }

        public Rate_Limit(
            uint Max_Rcpt,
            Object Whitelisted_Rcpts
        )
        {
            max_rcpt = Max_Rcpt;
            whitelisted_rcpts = Whitelisted_Rcpts;
        }
    }
}
namespace OPNsense.Rspamd
{
    public class Av
    {
        #region Parameters
        public bool attachmentsonly { get; set; }
        public bool forcereject { get; set; }
        public uint maxsize { get; set; }
        public Object whitelist { get; set; }
        #endregion Parameters

        public Av()
        {
            attachmentsonly = true;
            forcereject = true;
            maxsize = 20000000;
            whitelist = null;
        }

        public Av(
            byte Attachmentsonly,
            byte Forcereject,
            uint Maxsize,
            Object Whitelist
        )
        {
            attachmentsonly = (Attachmentsonly == 0) ? false : true;
            forcereject = (Forcereject == 0) ? false : true;
            maxsize = Maxsize;
            whitelist = Whitelist;
        }
    }
}
namespace OPNsense.Rspamd
{
    public class Dkim
    {
        #region Parameters
        public bool allow_envfrom_empty { get; set; }
        public bool allow_hdrfrom_mismatch { get; set; }
        public bool allow_hdrfrom_multiple { get; set; }
        public bool allow_username_mismatch { get; set; }
        public bool auth_only { get; set; }
        public uint cache_expire { get; set; }
        public uint cache_size { get; set; }
        public bool sign_local { get; set; }
        public bool skip_multi { get; set; }
        public uint time_jitter { get; set; }
        public bool trusted_only { get; set; }
        public bool try_fallback { get; set; }
        public PSObject use_domain { get; set; }
        public bool use_esld { get; set; }
        #endregion Parameters

        public Dkim()
        {
            allow_envfrom_empty = true;
            allow_hdrfrom_mismatch = true;
            allow_hdrfrom_multiple = true;
            allow_username_mismatch = true;
            auth_only = true;
            cache_expire = 0;
            cache_size = 0;
            sign_local = true;
            skip_multi = true;
            time_jitter = 0;
            trusted_only = true;
            try_fallback = true;
            use_domain = null;
            use_esld = true;
        }

        public Dkim(
            byte Allow_Envfrom_Empty,
            byte Allow_Hdrfrom_Mismatch,
            byte Allow_Hdrfrom_Multiple,
            byte Allow_Username_Mismatch,
            byte Auth_Only,
            uint Cache_Expire,
            uint Cache_Size,
            byte Sign_Local,
            byte Skip_Multi,
            uint Time_Jitter,
            byte Trusted_Only,
            byte Try_Fallback,
            PSObject Use_Domain,
            byte Use_Esld
        )
        {
            allow_envfrom_empty = (Allow_Envfrom_Empty == 0) ? false : true;
            allow_hdrfrom_mismatch = (Allow_Hdrfrom_Mismatch == 0) ? false : true;
            allow_hdrfrom_multiple = (Allow_Hdrfrom_Multiple == 0) ? false : true;
            allow_username_mismatch = (Allow_Username_Mismatch == 0) ? false : true;
            auth_only = (Auth_Only == 0) ? false : true;
            cache_expire = Cache_Expire;
            cache_size = Cache_Size;
            sign_local = (Sign_Local == 0) ? false : true;
            skip_multi = (Skip_Multi == 0) ? false : true;
            time_jitter = Time_Jitter;
            trusted_only = (Trusted_Only == 0) ? false : true;
            try_fallback = (Try_Fallback == 0) ? false : true;
            use_domain = Use_Domain;
            use_esld = (Use_Esld == 0) ? false : true;
        }
    }
}
namespace OPNsense.Rspamd
{
    public class Graylist
    {
        #region Parameters
        public uint expire { get; set; }
        public byte ipv4mask { get; set; }
        public byte ipv6mask { get; set; }
        public int max_data_len { get; set; }
        public uint timeout { get; set; }
        #endregion Parameters

        public Graylist()
        {
            expire = 0;
            ipv4mask = 19;
            ipv6mask = 64;
            max_data_len = 0;
            timeout = 0;
        }

        public Graylist(
            uint Expire,
            byte Ipv4mask,
            byte Ipv6mask,
            int Max_Data_Len,
            uint Timeout
        )
        {
            expire = Expire;
            ipv4mask = Ipv4mask;
            ipv6mask = Ipv6mask;
            max_data_len = Max_Data_Len;
            timeout = Timeout;
        }
    }
}
namespace OPNsense.Rspamd
{
    public class Milter_Headers
    {
        #region Parameters
        public bool enabled { get; set; }
        public bool enable_authentication_results { get; set; }
        public bool enable_extended_spam_headers { get; set; }
        public bool enable_spamd_bar { get; set; }
        public Object extended_headers_rcpt { get; set; }
        public bool skip_authenticated { get; set; }
        public bool skip_local { get; set; }
        #endregion Parameters

        public Milter_Headers()
        {
            enabled = true;
            enable_authentication_results = true;
            enable_extended_spam_headers = true;
            enable_spamd_bar = true;
            extended_headers_rcpt = null;
            skip_authenticated = true;
            skip_local = true;
        }

        public Milter_Headers(
            byte Enabled,
            byte Enable_Authentication_Results,
            byte Enable_Extended_Spam_Headers,
            byte Enable_Spamd_Bar,
            Object Extended_Headers_Rcpt,
            byte Skip_Authenticated,
            byte Skip_Local
        )
        {
            enabled = (Enabled == 0) ? false : true;
            enable_authentication_results = (Enable_Authentication_Results == 0) ? false : true;
            enable_extended_spam_headers = (Enable_Extended_Spam_Headers == 0) ? false : true;
            enable_spamd_bar = (Enable_Spamd_Bar == 0) ? false : true;
            extended_headers_rcpt = Extended_Headers_Rcpt;
            skip_authenticated = (Skip_Authenticated == 0) ? false : true;
            skip_local = (Skip_Local == 0) ? false : true;
        }
    }
}
namespace OPNsense.Rspamd
{
    public class Multimap
    {
        #region Parameters
        public Object badfileextension { get; set; }
        #endregion Parameters

        public Multimap()
        {
            badfileextension = null;
        }

        public Multimap(
            Object Badfileextension
        )
        {
            badfileextension = Badfileextension;
        }
    }
}
namespace OPNsense.Rspamd
{
    public class MxCheck
    {
        #region Parameters
        public bool enabled { get; set; }
        public uint expire { get; set; }
        #endregion Parameters

        public MxCheck()
        {
            enabled = true;
            expire = 86400;
        }

        public MxCheck(
            byte Enabled,
            uint Expire
        )
        {
            enabled = (Enabled == 0) ? false : true;
            expire = Expire;
        }
    }
}
namespace OPNsense.Rspamd
{
    public class Phishing
    {
        #region Parameters
        public bool openphish_enabled { get; set; }
        public string openphish_map { get; set; }
        public bool openphish_premium_enabled { get; set; }
        public bool phishtank_enabled { get; set; }
        public string phishtank_map { get; set; }
        #endregion Parameters

        public Phishing()
        {
            openphish_enabled = true;
            openphish_map = null;
            openphish_premium_enabled = true;
            phishtank_enabled = true;
            phishtank_map = null;
        }

        public Phishing(
            byte Openphish_Enabled,
            string Openphish_Map,
            byte Openphish_Premium_Enabled,
            byte Phishtank_Enabled,
            string Phishtank_Map
        )
        {
            openphish_enabled = (Openphish_Enabled == 0) ? false : true;
            openphish_map = Openphish_Map;
            openphish_premium_enabled = (Openphish_Premium_Enabled == 0) ? false : true;
            phishtank_enabled = (Phishtank_Enabled == 0) ? false : true;
            phishtank_map = Phishtank_Map;
        }
    }
}
namespace OPNsense.Rspamd.rate_limit
{
    public class Bounce
    {
        #region Parameters
        public uint count { get; set; }
        public uint time { get; set; }
        public PSObject time_unit { get; set; }
        #endregion Parameters

        public Bounce()
        {
            count = 0;
            time = 0;
            time_unit = null;
        }

        public Bounce(
            uint Count,
            uint Time,
            PSObject Time_Unit
        )
        {
            count = Count;
            time = Time;
            time_unit = Time_Unit;
        }
    }
}
namespace OPNsense.Rspamd.rate_limit
{
    public class Bounce_Ip
    {
        #region Parameters
        public uint count { get; set; }
        public uint time { get; set; }
        public PSObject time_unit { get; set; }
        #endregion Parameters

        public Bounce_Ip()
        {
            count = 0;
            time = 0;
            time_unit = null;
        }

        public Bounce_Ip(
            uint Count,
            uint Time,
            PSObject Time_Unit
        )
        {
            count = Count;
            time = Time;
            time_unit = Time_Unit;
        }
    }
}
namespace OPNsense.Rspamd.rate_limit
{
    public class Per_Ip
    {
        #region Parameters
        public uint count { get; set; }
        public uint time { get; set; }
        public PSObject time_unit { get; set; }
        #endregion Parameters

        public Per_Ip()
        {
            count = 0;
            time = 0;
            time_unit = null;
        }

        public Per_Ip(
            uint Count,
            uint Time,
            PSObject Time_Unit
        )
        {
            count = Count;
            time = Time;
            time_unit = Time_Unit;
        }
    }
}
namespace OPNsense.Rspamd.rate_limit
{
    public class Per_Ip_From
    {
        #region Parameters
        public uint count { get; set; }
        public uint time { get; set; }
        public PSObject time_unit { get; set; }
        #endregion Parameters

        public Per_Ip_From()
        {
            count = 0;
            time = 0;
            time_unit = null;
        }

        public Per_Ip_From(
            uint Count,
            uint Time,
            PSObject Time_Unit
        )
        {
            count = Count;
            time = Time;
            time_unit = Time_Unit;
        }
    }
}
namespace OPNsense.Rspamd.rate_limit
{
    public class Per_Recipient
    {
        #region Parameters
        public uint count { get; set; }
        public uint time { get; set; }
        public PSObject time_unit { get; set; }
        #endregion Parameters

        public Per_Recipient()
        {
            count = 0;
            time = 0;
            time_unit = null;
        }

        public Per_Recipient(
            uint Count,
            uint Time,
            PSObject Time_Unit
        )
        {
            count = Count;
            time = Time;
            time_unit = Time_Unit;
        }
    }
}
namespace OPNsense.Rspamd.rate_limit
{
    public class User
    {
        #region Parameters
        public uint count { get; set; }
        public uint time { get; set; }
        public PSObject time_unit { get; set; }
        #endregion Parameters

        public User()
        {
            count = 0;
            time = 0;
            time_unit = null;
        }

        public User(
            uint Count,
            uint Time,
            PSObject Time_Unit
        )
        {
            count = Count;
            time = Time;
            time_unit = Time_Unit;
        }
    }
}
namespace OPNsense.Rspamd
{
    public class Spamtrap
    {
        #region Parameters
        public bool enabled { get; set; }
        public bool fuzzy_learning { get; set; }
        public bool spam_learning { get; set; }
        public Object spam_recipients { get; set; }
        #endregion Parameters

        public Spamtrap()
        {
            enabled = true;
            fuzzy_learning = true;
            spam_learning = true;
            spam_recipients = null;
        }

        public Spamtrap(
            byte Enabled,
            byte Fuzzy_Learning,
            byte Spam_Learning,
            Object Spam_Recipients
        )
        {
            enabled = (Enabled == 0) ? false : true;
            fuzzy_learning = (Fuzzy_Learning == 0) ? false : true;
            spam_learning = (Spam_Learning == 0) ? false : true;
            spam_recipients = Spam_Recipients;
        }
    }
}
namespace OPNsense.Rspamd
{
    public class Spf
    {
        #region Parameters
        public uint spf_cache_expire { get; set; }
        public uint spf_cache_size { get; set; }
        #endregion Parameters

        public Spf()
        {
            spf_cache_expire = 0;
            spf_cache_size = 2;
        }

        public Spf(
            uint Spf_Cache_Expire,
            uint Spf_Cache_Size
        )
        {
            spf_cache_expire = Spf_Cache_Expire;
            spf_cache_size = Spf_Cache_Size;
        }
    }
}
namespace OPNsense.Rspamd
{
    public class Surbl
    {
        #region Parameters
        public Object exceptions { get; set; }
        public Object whitelist { get; set; }
        #endregion Parameters

        public Surbl()
        {
            exceptions = null;
            whitelist = null;
        }

        public Surbl(
            Object Exceptions,
            Object Whitelist
        )
        {
            exceptions = Exceptions;
            whitelist = Whitelist;
        }
    }
}
namespace OPNsense.Rspamd
{
    public class General
    {
        #region Parameters
        public bool enabled { get; set; }
        public bool enable_redis_plugin { get; set; }
        #endregion Parameters

        public General()
        {
            enabled = true;
            enable_redis_plugin = true;
        }

        public General(
            byte Enabled,
            byte Enable_Redis_Plugin
        )
        {
            enabled = (Enabled == 0) ? false : true;
            enable_redis_plugin = (Enable_Redis_Plugin == 0) ? false : true;
        }
    }
}
