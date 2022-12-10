// Created by Daniele Formichelli.

import Foundation
import Utils

/// https://adventofcode.com/2022/day/7
struct Year2022Day7: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.fileSystemAndFolderSizes(input).foldersSizes.values.filter { $0 <= 100000 }.sum
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let folderSizes = Self.fileSystemAndFolderSizes(input).foldersSizes
    let totalSpace = 70000000
    let requiredSpace = 30000000
    let availableSpace = totalSpace - folderSizes[[]]!
    let spaceToReclaim = requiredSpace - availableSpace
    return folderSizes.values.sorted().first { $0 >= spaceToReclaim }!
  }

  static func fileSystemAndFolderSizes(_ input: String) -> (root: Folder, foldersSizes: [[String]: Int]) {
    let root = Folder(parent: nil)
    var currentFolder = root
    input.commands.forEach { command in
      switch command {
      case .cd(let to):
        if to == "/" {
          currentFolder = root
        } else if to == ".." {
          currentFolder = currentFolder.parent!
        } else {
          if let nextFolder = currentFolder.folders[to] {
            currentFolder = nextFolder
          } else {
            currentFolder.folders[to] = .init(parent: currentFolder)
          }
        }
      case .ls(let output):
        output.forEach { lsOutput in
          switch lsOutput {
          case .folder(let name):
            if currentFolder.folders[name] == nil {
              currentFolder.folders[name] = .init(parent: currentFolder)
            }
          case .file(let name, let size):
            currentFolder.files[name] = size
          }
        }
      }
    }

    var foldersSizes: [[String]: Int] = [:]
    _ = Self.foldersSizes(folder: root, path: [], folderSize: &foldersSizes)
    return (root: root, foldersSizes: foldersSizes)
  }

  static func foldersSizes(folder: Folder, path: [String], folderSize: inout [[String]: Int]) -> Int {
    if let cachedSize = folderSize[path] {
      return cachedSize
    }

    var size = 0
    for innerFileSize in folder.files.values {
      size += innerFileSize
    }
    for (name, innerFolder) in folder.folders {
      size += Self.foldersSizes(folder: innerFolder, path: path + [name], folderSize: &folderSize)
    }
    folderSize[path] = size
    return size
  }
}

class Folder {
  var parent: Folder?
  var folders: [String: Folder]
  var files: [String: Int]

  internal init(parent: Folder?, folders: [String : Folder] = [:], files: [String : Int] = [:]) {
    self.parent = parent
    self.folders = folders
    self.files = files
  }
}

enum Command {
  case cd(String)
  case ls(output: [LsOutput])
}

enum LsOutput {
  case file(name: String, size: Int)
  case folder(name: String)
}

extension String {
  var commands: [Command] {
    var commands: [Command] = []
    var command: Command!
    for line in self.lines {
      if line.starts(with: "$ ") {
        if command != nil {
          commands.append(command)
        }
        let split = line.components(separatedBy: " ")
        switch split[1] {
        case "cd":
          command = .cd(split[2])
        case "ls":
          command = .ls(output: [])
        default:
          fatalError("Unknown command \(split[1])")
        }
      } else {
        switch command {
        case .ls(let output):
          if line.starts(with: "dir ") {
            command = .ls(output: output + [.folder(name: String(line.dropFirst(4)))])
          } else {
            let split = line.components(separatedBy: " ")
            command = .ls(output: output + [.file(name: String(split[1]), size: Int(split[0])!)])
          }
        case .cd, .none:
          fatalError("Command \(command!) should have no output")
        }
      }
    }
    commands.append(command)
    return commands
  }
}
