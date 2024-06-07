require("sessions").setup({
    events = { "BufEnter", "BufLeave" },
    session_filepath = ".nvim/session",
})
