local DEBUG = true

FistedDKP_Debug = FistedDKP:NewModule("FistedDKP_Debug")

function FistedDKP_Debug:Message(message)
    if not DEBUG then
        return
    end

    print(message)
end