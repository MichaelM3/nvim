local dap, dapui = require("dap"), require("dapui")

vim.keymap.set('n', '<leader>dc', function() dap.continue() end)
vim.keymap.set('n', '<leader>dr', function() dap.run_last() end)
vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<leader>de', function () dapui.toggle() end)

require('dap-python').setup(os.getenv("VIRTUAL_ENV") .. '/bin/python')
table.insert(dap.configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'FastAPI',
    program = function()
        return './main.py'
    end,
    pythonPath = function()
        return 'python'
    end,
})
table.insert(dap.configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'FastAPI module',
    module = 'uvicorn',
    args = {
        'app.main:app',
        -- '--reload', -- doesn't work
        '--use-colors',
    },
    pythonPath = 'python',
    console = 'integratedTerminal',
})

dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end
