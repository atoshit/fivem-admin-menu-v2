local Config <const> = {
    Debug = true,

    Menu = {
        Banner = "https://cdn.discordapp.com/attachments/1270395429883744391/1290759094503735396/admin-banner.png?ex=66fda095&is=66fc4f15&hm=0954e28413ee6192f91f007a3107a16019305f2cb2a7aa5a234e1f4a3a5b1772&",
        Color = "#573cc7" -- https://htmlcolorcodes.com/
    },

    Keys = {
        OpenMenu = "F9",
        Noclip = "F10"
    },

    Colors = {
        { Label = "Rouge", Color = "~r~" },
        { Label = "Vert", Color = "~g   ~" },
        { Label = "Bleu", Color = "~b~" },
        { Label = "Jaune", Color = "~y~" },
        { Label = "Violet", Color = "~p~" },
        { Label = "Orange", Color = "~o~" },
    }
}

_ENV.Config = Config