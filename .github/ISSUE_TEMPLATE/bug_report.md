name: Bug Report
description: Report a bug or issue
title: "[BUG] "
labels: ["bug", "needs-investigation"]
assignees: []

body:
  - type: markdown
    attributes:
      value: |
        Thanks for taking the time to fill out this bug report!

  - type: textarea
    id: description
    attributes:
      label: Description
      description: A clear description of what the bug is
      placeholder: Describe the issue...
    validations:
      required: true

  - type: textarea
    id: reproduction
    attributes:
      label: Steps to Reproduce
      description: Steps to reproduce the behavior
      placeholder: |
        1. Start the node with...
        2. Run the command...
        3. See the error...
    validations:
      required: true

  - type: textarea
    id: expected
    attributes:
      label: Expected Behavior
      description: What did you expect to happen?
      placeholder: Describe what should have happened...
    validations:
      required: true

  - type: textarea
    id: logs
    attributes:
      label: Logs / Error Output
      description: Relevant logs or error messages
      render: shell

  - type: dropdown
    id: environment
    attributes:
      label: Environment
      options:
        - Docker Compose
        - Manual Installation
        - Development
        - Other
    validations:
      required: true

  - type: input
    id: os
    attributes:
      label: Operating System
      placeholder: Ubuntu 20.04, macOS 12, Windows 11, etc.
    validations:
      required: false

  - type: textarea
    id: additional
    attributes:
      label: Additional Context
      description: Any other context about the problem
      placeholder: Add any other context here...
