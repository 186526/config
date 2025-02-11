{ pkgs, dns, ... }: let
    name = "an.dn42";
    zone = with dns.lib.combinators; {
        SOA = {
            nameServer = "ns1";
            adminEmail = "noc@anillc.cn";
            serial = 2021112201;
        };
        NS = [ "ns1.an.dn42." ];
        subdomains = {
            "ns1".A    = [ "172.22.167.97"      ];
            "ns1".AAAA = [ "fdc9:83c1:d0ce::1"  ];
            
            "las".A    = [ "172.22.167.97"      ];
            "las".AAAA = [ "fdc9:83c1:d0ce::1"  ];
            "bj".A     = [ "172.22.167.99"      ];
            "bj".AAAA  = [ "fdc9:83c1:d0ce::3"  ];
            "hk".A     = [ "172.22.167.100"     ];
            "hk".AAAA  = [ "fdc9:83c1:d0ce::4"  ];
            "de".A     = [ "172.22.167.102"     ];
            "de".AAAA  = [ "fdc9:83c1:d0ce::6"  ];
            "wh".A     = [ "172.22.167.103"     ];
            "wh".AAAA  = [ "fdc9:83c1:d0ce::7"  ];
            "hz".A     = [ "172.22.167.104"     ];
            "hz".AAAA  = [ "fdc9:83c1:d0ce::8"  ];
            "sh".A     = [ "172.22.167.105"     ];
            "sh".AAAA  = [ "fdc9:83c1:d0ce::9"  ];
            "sh2".A    = [ "172.22.167.106"     ];
            "sh2".AAAA = [ "fdc9:83c1:d0ce::10" ];
            "jx".A     = [ "172.22.167.107"     ];
            "jx".AAAA  = [ "fdc9:83c1:d0ce::11" ];

            "mc".A     = [ "172.22.167.105"     ];
        };
    };
in pkgs.writeText name (dns.lib.toString name zone)