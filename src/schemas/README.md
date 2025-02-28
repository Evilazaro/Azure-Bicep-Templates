# Azure Bicep Templates - JSON Schemas

This directory is designated for storing all the JSON schemas for the Azure Services YAML configuration files. These schemas are used to validate and ensure the correctness of the configuration files.

## Examples

### Example 1: Virtual Network Schema

```json
{
    "$schema": "http://json-schema.org/draft-07/schema#",
    "title": "Virtual Network",
    "type": "object",
    "properties": {
        "name": {
            "type": "string",
            "description": "The name of the virtual network."
        },
        "addressSpace": {
            "type": "array",
            "items": {
                "type": "string"
            },
            "description": "The address space of the virtual network."
        }
    },
    "required": ["name", "addressSpace"]
}
```

### Example 2: Storage Account Schema

```json
{
    "$schema": "http://json-schema.org/draft-07/schema#",
    "title": "Storage Account",
    "type": "object",
    "properties": {
        "name": {
            "type": "string",
            "description": "The name of the storage account."
        },
        "sku": {
            "type": "string",
            "description": "The SKU of the storage account."
        },
        "kind": {
            "type": "string",
            "description": "The kind of the storage account."
        }
    },
    "required": ["name", "sku", "kind"]
}
```

### Example 3: SQL Database Schema

```json
{
    "$schema": "http://json-schema.org/draft-07/schema#",
    "title": "SQL Database",
    "type": "object",
    "properties": {
        "name": {
            "type": "string",
            "description": "The name of the SQL database."
        },
        "edition": {
            "type": "string",
            "description": "The edition of the SQL database."
        },
        "maxSizeBytes": {
            "type": "integer",
            "description": "The maximum size of the SQL database in bytes."
        }
    },
    "required": ["name", "edition", "maxSizeBytes"]
}
```