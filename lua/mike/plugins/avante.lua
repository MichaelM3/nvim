-- Avante.nvim: Cursor (ACP) for chat; Morph is used only for Fast Apply (`edit_file`).
-- Set `MORPH_API_KEY` in the environment (see https://morphllm.com/api-keys).
-- :AvanteACPModels needs ACP configOptions from the agent; Cursor often omits them
-- (https://github.com/yetone/avante.nvim/issues/2977).
return {
	"yetone/avante.nvim",
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- ⚠️ must add this setting! ! !
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = false,
	---@module "avante"
	---@type avante.Config
	opts = {
		provider = "cursor",
		mode = "agentic",
		acp_providers = {
			cursor = {
				command = "/home/unbalanced/.local/bin/agent",
				args = { "acp" },
				auth_method = "cursor_login",
				env = {
					HOME = os.getenv("HOME"),
					PATH = os.getenv("PATH"),
				},
			},
		},
		-- Fast Apply always calls the `morph` provider (not your main `provider`).
		providers = {
			morph = {
				endpoint = "https://api.morphllm.com/v1",
				model = "morph-v3-fast",
				api_key_name = "MORPH_API_KEY",
				timeout = 30000,
			},
		},
		behaviour = {
			auto_focus_sidebar = true,
			auto_approve_tool_permissions = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = true,
			auto_suggestions = false,
			auto_set_keymaps = true,
			auto_add_current_file = true,
			minimize_diff = true,
			auto_check_diagnostics = true,
			confirmation_ui_style = "inline_buttons",
			acp_follow_agent_locations = true,
			enable_fastapply = true,
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-telescope/telescope.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-tree/nvim-web-devicons",
		"stevearc/dressing.nvim",
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
	},
}
