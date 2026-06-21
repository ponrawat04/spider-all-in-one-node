name: Feature Request
description: Suggest an idea for this project
title: "[FEATURE] "
labels: ["enhancement", "feature-request"]
assignees: []

body:
  - type: markdown
    attributes:
      value: |
        Thanks for your interest in improving Spider All-in-One Node!

  - type: textarea
    id: description
    attributes:
      label: Feature Description
      description: Describe the feature you'd like to see
      placeholder: Explain what you want to add...
    validations:
      required: true

  - type: textarea
    id: problem
    attributes:
      label: Problem It Solves
      description: What problem or need does this solve?
      placeholder: Describe the problem...
    validations:
      required: true

  - type: textarea
    id: solution
    attributes:
      label: Proposed Solution
      description: How should this feature work?
      placeholder: Describe your solution...
    validations:
      required: true

  - type: textarea
    id: alternatives
    attributes:
      label: Alternative Solutions
      description: Any alternative approaches you've considered
      placeholder: Describe alternatives...

  - type: textarea
    id: additional
    attributes:
      label: Additional Context
      description: Any other information
      placeholder: Add any other context here...
