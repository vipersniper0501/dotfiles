return {
    {
        "puremourning/vimspector",
        config = function()
            local keyset = vim.api.nvim_set_keymap
            -- vim.g.vimspector_enable_mappings = "HUMAN"
            vim.g.vimspector_install_gadgets = {
                "debugpy", "vscode-cpptools", "CodeLLDB", "vscode-java-debug", "vscode-java-language-server"
            }

            vim.g.vimscpector_sign_priority = {
                vimspectorBP =              997,
                vimspectorBPCond =          997,
                vimspectorBPLog =           997,
                vimspectorBPDisabled =      997,
                vimspectorPC =              998,
                vimspectorPCBP =            999,
                vimspectorCurrentThread =   997,
                vimspectorCurrentFrame =    997
            }

            keyset("n", "<F2>", ":VimspectorReset<CR>", {noremap = true})
            keyset("n", "<F3>", "<Plug>VimspectorStop", {noremap = true})
            keyset("n", "<F4>", "<Plug>VimspectorRestart", {noremap = true})
            keyset("n", "<F5>", "<Plug>VimspectorContinue", {noremap = true})
            keyset("n", "<F6>", "<Plug>VimspectorPause", {noremap = true})
            keyset("n", "<F8>", "<Plug>VimspectorAddFunctionBreakpoint", {noremap = true})
            keyset("n", "<F9>", "<Plug>VimspectorToggleBreakpoint", {noremap = true})
            keyset("n", "<leader><F9>", "<Plug>VimspectorDisassemble", {noremap = true})
            keyset("n", "<F10>", "<Plug>VimspectorStepOver", {noremap = true})
            keyset("n", "<F11>", "<Plug>VimspectorStepInto", {noremap = true})
            keyset("n", "<F12>", "<Plug>VimspectorStepOut", {noremap = true})

            keyset("n", "<leader>di", "<Plug>VimspectorBalloonEval", {})
        end
    },
}
