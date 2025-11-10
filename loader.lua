local GAMES = {
    {
        name = "Fish It",
        gameId = 121864768012064,
        scriptUrl = "https://raw.githubusercontent.com/Xeismonium4/Project-R/refs/heads/main/mancing-mania.lua"
    },
    {
        name = "Violence District",
        gameId = 93978595733734,
        scriptUrl = "https://raw.githubusercontent.com/Xeismonium4/Project-R/refs/heads/main/distrik-kerusuhan.lua"
    },
    {
        name = "Universal Script",
        gameId = 0,
        scriptUrl = ""
    }
}

local currentGameId = game.GameId
print("[Loader] Game ID Terdeteksi: " .. currentGameId)

local gameFound = false

for _, gameConfig in ipairs(GAMES) do
    if gameConfig.gameId ~= 0 and currentGameId == gameConfig.gameId then
        print("[Loader] Game ditemukan: " .. gameConfig.name)
        
        if gameConfig.scriptUrl ~= "" then
            print("[Loader] Mengunduh script...")
            local success, script = pcall(function()
                return game:HttpGet(gameConfig.scriptUrl)
            end)
            
            if success and script then
                print("[Loader] Script berhasil diunduh. Menjalankan...")
                local exec_success, exec_error = pcall(function()
                    loadstring(script)()
                end)
                
                if exec_success then
                    print("[Loader] Script berhasil dijalankan!")
                else
                    print("[Loader] Error: " .. tostring(exec_error))
                end
            else
                print("[Loader] Gagal download script")
            end
        else
            print("[Loader] Script URL belum dikonfigurasi")
        end
        
        gameFound = true
        break
    end
end

if not gameFound then
    local universalScript = GAMES[3]
    
    if universalScript.gameId ~= 0 and universalScript.scriptUrl ~= "" then
        print("[Loader] Menggunakan Universal Script untuk game ini")
        print("[Loader] Mengunduh script...")
        
        local success, script = pcall(function()
            return game:HttpGet(universalScript.scriptUrl)
        end)
        
        if success and script then
            print("[Loader] Script berhasil diunduh. Menjalankan...")
            local exec_success, exec_error = pcall(function()
                loadstring(script)()
            end)
            
            if exec_success then
                print("[Loader] Script berhasil dijalankan!")
            else
                print("[Loader] Error: " .. tostring(exec_error))
            end
        else
            print("[Loader] Gagal download script")
        end
    else
        print("[Loader] Universal Script belum dikonfigurasi")
    end
end
