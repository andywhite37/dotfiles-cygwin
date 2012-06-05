#! /usr/bin/perl -w
use strict;
use warnings;

my @gridNames =
(
"BSAUTH_HDR",
"BSDEVS",
"BSGROU_SSC",
"BSUSER_UOG",
"LVFLCC",
"LVFLPERS",
"LVIRACT",
"LVIREVNT",
"LVIRMATL",
"LVIROBJ",
"LVISSUEPICKLIST",
"LVPARTRETURNWO",
"LVRECPTPARTS",
"LVREFNUM_RETN",
"LVRETURNREASON",
"LVSTOSACTREQ",
"SSBINL",
"SSIUSS",
"SSIUSS_TRL",
"SSPART",
"SSPART_BIS",
"SSPICK_PAR",
"SSPINV",
"SSPINV_PAR",
"SSRECV",
"SSRECV_XDL",
"SSRETN_TRL",
"SSRQSS_RQL",
"SSSTOR",
"SSSTSR",
"SSSTSR_TRL",
"WSEMPS",
"WSFLTK",
"WSJOBS_PAR",
"WSMATL_PAR"
);

foreach my $gridName (@gridNames)
{
    print("[ApplicationScopedSetting]\n");
    print("[DebuggerNonUserCode]\n");
    print("[DefaultSettingValue(\"0\")]\n");
    print("public string ${gridName}_DataSpyID\n");
    print("{\n");
    print("    get\n");
    print("    {\n");
    print("        return this[\"${gridName}_DataSpyID\"].ToString();\n");
    print("    }\n");
    print("    set\n");
    print("    {\n");
    print("        if (${gridName}_DataSpyID == value) return;\n");
    print("        this[\"${gridName}_DataSpyID\"] = value;\n");
    print("    }\n");
    print("}\n");
    print("\n");
}
