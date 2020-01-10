local _, fisted = ...;
local _G = _G;
local L = fisted.L;

fisted.version = 'v0.0.1'
fisted.build = '00001'


local faction = UnitFactionGroup("player")
local classes = {
    druid = {
        name = "Druid",
        colors = {
            hex = "FF7D0A"
        }
    },
    hunter = {
        name = "Hunter",
        colors = {
            hex = "ABD473"
        }
    },
    mage = {
        name = "Mage",
        colors = {
            hex = "40C7EB"
        }
    },
    paladin = {
        name = "Paladin",
        colors = {
            hex = "F58CBA"
        }
    },
    priest = {
        name = "Priest",
        colors = {
            hex = "FFFFFF"
        }
    },
    rogue = {
        name = "Rogue",
        colors = {
            hex = "FFF569"
        }
    },
    shaman = {
        name = "Shaman",
        colors = {
            hex = "F58CBA"
        }
    },
    warlock = {
        name = "Warlock",
        colors = {
            hex = "8787ED"
        }
    },
    warrior = {
        name = "Warrior",
        colors = {
            hex = "C79C6E"
        }
    }
}


if faction == "Horde" then
    fisted.faction = faction
    fisted.classes = {
        druid = classes.druid,
        hunter = classes.hunter,
        mage = classes.mage,
        priest = classes.priest,
        rogue = classes.rogue,
        shaman = classes.shaman,
        warlock = classes.warlock,
        warrior = classes.warrior
    }
elseif faction == "Alliance" then
    fisted.classes = {
        druid = classes.druid,
        hunter = classes.hunter,
        mage = classes.mage,
        paladin = classes.paladin,
        priest = classes.priest,
        rogue = classes.rogue,
        warlock = classes.warlock,
        warrior = classes.warrior
    }
end

fisted.encounters = {
    MC = {
        LUCIFRON = 663,
        MAGMADAR = 664,
        GEHENNAS = 665,
        GARR = 666,
        SHAZZRAH = 667,
        BARON = 668,
        SULFRON = 669,
        GOLEMAGG = 670,
        MAJORDOMO = 671,
        RAGNAROS = 672
    },
    ONY = {
        ONYXIA = 1084
    },
    BWL = {
        RAZORGORE = 610,
        VAELESTRASZ = 611,
        BROODLORD = 612,
        FIREMAW = 613,
        EBONROC = 614,
        FLAMEGOR = 615,
        CHROMAGGUS = 616,
        NEFARIAN = 617
    },
    ZG = {
        BLOODLORD = 787,
        MADNESS = 788,
        THEKAL = 789,
        GAHZRANKA = 790,
        ARLOKK = 791,
        JINDO = 792,
        HAKKAR = 793
    },
    RAQ = {
        KURINNAXX = 718,
        RAJAXX = 719,
        MOAM = 720,
        BURU = 721,
        AYAMISS = 722,
        OSSIRIAN = 723
    },
    TAQ = {
        SKERAM = 709,
        ROYALTY = 710,
        SARTURA = 711,
        UNYIELDING = 712,
        VISCIDIUS = 713,
        HUHURAN = 714,
        EMPERORS = 715,
        OURO = 716,
        CTHUN = 717
    },
    NAXX = {
        ANUBREKHAN = 1107,
        GLUTH = 1108,
        GOTHIK = 1109,
        FAERLINA = 1110,
        GROBBULUS = 1111,
        HEIGAN = 1112,
        RAZUVIOUS = 1113,
        KELTHUZARD = 1114,
        LOATHEB = 1115,
        MAEXXNA = 1116,
        NOTH = 1117,
        PATCHWERK = 1118,
        SAPPHIRON = 1119,
        THADDIUS = 1120,
        FOURHORSEMEN = 1121
    },
    WORLD = {
        AZUREGOS = 0,
        KAZZAK = 0,
        EMERISS = 0,
        LETHON = 0,
        YSONDRE = 0,
        TAERAR = 0,
    }
}