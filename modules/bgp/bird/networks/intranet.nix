pkgs: cfg: ''
    ipv4 table ibgp_table_v4;
    ipv6 table ibgp_table_v6;
    ipv4 table igp_table_v4;
    ipv6 table igp_table_v6;

    protocol pipe {
        table ibgp_table_v4;
        peer table dn42_table_v4;
        import all;
        export filter {
            if !utils_dn42_valid() then reject;
            accept;
        };
    }

    protocol pipe {
        table ibgp_table_v6;
        peer table dn42_table_v6;
        import all;
        export filter {
            if !utils_dn42_valid() then reject;
            accept;
        };
    }

    protocol pipe {
        table ibgp_table_v4;
        peer table internet_table_v4;
        import all;
        export filter {
            if utils_dn42_valid() then reject;
            accept;
        };
    }

    protocol pipe {
        table ibgp_table_v6;
        peer table internet_table_v6;
        import all;
        export filter {
            if utils_dn42_valid() then reject;
            accept;
        };
    }

    template bgp ibgp_peers {
        graceful restart;
        local as INTRANET_ASN;
        ipv4 {
            table ibgp_table_v4;
            igp table master4;
            next hop self ebgp;
            import all;
            export all;
        };
        ipv6 {
            table ibgp_table_v6;
            igp table master6;
            next hop self ebgp;
            import all;
            export all;
        };
    }

    ${builtins.foldl' (acc: x: ''
        ${acc}
        ${if x.meta.name == cfg.meta.name then "" else ''
            protocol bgp i${x.meta.name} from ibgp_peers {
                neighbor 2602:feda:da0::${x.meta.id} as INTRANET_ASN;
            }
        ''}
    '') "" (import ../../../../machines).list}
''