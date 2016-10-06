Feature: Help
  Scenario: Running the help command
    When I successfully run `rp help`
    Then the output should contain:
    """
    Commands:
      rp cdq_model         # Generate a CDQ Model and migration
      rp cdq_table_screen  # Generate a CDQ Table Screen
      rp help [COMMAND]    # Describe available commands or one specific command
    """
