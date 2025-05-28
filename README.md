# C++ Configuration System

A lightweight, cross-platform configuration management library for C++ applications that follows the XDG Base Directory Specification.

## Features

- Simple key-value configuration file format
- Automatic creation of configuration directories and files
- XDG Base Directory Specification compliance
- Easy API for reading and writing configuration values
- Enum-based configuration key system for type safety

## Installation

### Prerequisites

- C++ compiler with C++11 support
- Standard C++ libraries

### Adding to Your Project

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/cpp-config-system.git
   ```

2. Include the header and source files in your project:
   ```cpp
   #include "path/to/cpp-config-system/src/include/config.h"
   ```

3. Update the `PROJECT_FOLDER` constant in `config.h` to match your application name:
   ```cpp-config-system/src/include/config.h#L5
   const std::string PROJECT_FOLDER = "game_name";
   ```

## Usage

### Basic Setup

First, define your configuration keys by uncommenting and modifying the enum in `config.h`:

```cpp-config-system/src/include/config.h#L19-30
    std::map<int, std::string> getConfigKeys = {
        {KB_UP, "KB_UP"}, // Add your key bindings here
        {KB_DOWN, "KB_DOWN"},
        {KB_LEFT, "KB_LEFT"},
        {KB_RIGHT, "KB_RIGHT"},
    };

  public:
    Config();
    enum CONFIG_KEYS {
        KB_UP = 0,
        KB_DOWN,
        KB_LEFT,
        KB_RIGHT,
    };
```

Then, set up your default configuration by modifying the `createDefaultConfig()` method:

```cpp-config-system/src/config.cpp#L98-104
void Config::createDefaultConfig() {
    addPair(getConfigKeys.at(CONFIG_KEYS::KB_DOWN), "s");
    addPair(getConfigKeys.at(CONFIG_KEYS::KB_UP), "w");
    addPair(getConfigKeys.at(CONFIG_KEYS::KB_LEFT), "a");
    addPair(getConfigKeys.at(CONFIG_KEYS::KB_RIGHT), "d");
    // Add more default configurations as needed
}
```

### Reading Configuration Values

```cpp
/dev/null/example.cpp#L1-7
#include "include/config.h"

int main() {
    Config config;
    std::string upKey = config.getConfig(Config::KB_UP); // Returns "w"
    // Use the configuration value in your application
}
```

### Configuration File Location

The configuration file will be created at:
- `$XDG_CONFIG_HOME/game_name/config.txt` if `XDG_CONFIG_HOME` is set
- `$HOME/.config/game_name/config.txt` otherwise

### Configuration File Format

The configuration file uses a simple key=value format:
```
KB_UP=w
KB_DOWN=s
KB_LEFT=a
KB_RIGHT=d
```

## API Reference

### Constructor

```cpp-config-system/src/config.cpp#L9-43
Config::Config() {
    // Creates configuration directory if it doesn't exist
    // Creates configuration file with default values if it doesn't exist
}
```
