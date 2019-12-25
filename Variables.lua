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
    mc = {
        lucifron = 663,
        magmadar = 664,
        gehennas = 665,
        garr = 666,
        shazzrah = 667,
        baron = 668,
        sulfuron = 669,
        golemagg = 670,
        majordomo = 671,
        ragnaros = 672
    },
    onyxia = {
        onyxia = 1084
    },
    bwl = {
        razorgore = 610,
        vaelestrasz = 611,
        broodlord = 612,
        firemaw = 613,
        ebonroc = 614,
        flamegor = 615,
        chromaggus = 616,
        nefarian = 617
    },
    zg = {
        bloodlord = 787,
        madness = 788,
        thekal = 789,
        gahzranka = 790,
        arlokk = 791,
        jindo = 792,
        hakkar = 793
    },
    raq = {
        kurinnaxx = 718,
        rajaxx = 719,
        moam = 720,
        buru = 721,
        ayamiss = 722,
        ossirian = 723
    },
    taq = {
        skeram = 709,
        royalty = 710,
        sartura = 711,
        unyielding = 712,
        viscidius = 713,
        huhuran = 714,
        emperors = 715,
        ouro = 716,
        cthun = 717
    },
    naxx = {
        anubrekhan = 1107,
        gluth = 1108,
        gothik = 1109,
        faerlina = 1110,
        grobbulus = 1111,
        heigan = 1112,
        razuvious = 1113,
        kelthuzad = 1114,
        loatheb = 1115,
        maexxna = 1116,
        noth = 1117,
        patchwerk = 1118,
        sapphiron = 1119,
        thaddius = 1120,
        fourhorsemen = 1121
    },
    world = {
        azuregos = nil,
        kazzak = nil,
        emeriss = nil,
        lethon = nil,
        ysondre = nil,
        taerar = nil,
    }
}