import ExpoModulesCore
import ExpoModulesWorklets

// `_uiRuntime` is reached through `EXAppContextProtocol` rather than
// directly on `AppContext` because Swift 6.3 drops the Swift-class
// declaration during precompiled-xcframework deserialization — routing
// through the ObjC protocol resolves via the clang bridge instead. See
// `EXWorkletsUIRuntimeFactory.h` for the full explanation.
public final class WorkletsTesterModule: Module {
  public func definition() -> ModuleDefinition {
    Name("WorkletsTesterModule")

    Function("executeWorklet") { (worklet: Worklet) in
      guard let uiRuntime = (appContext as? any EXAppContextProtocol)?._uiRuntime as? WorkletRuntime else {
        throw Exceptions.RuntimeLost()
      }
      worklet.execute(on: uiRuntime)
    }

    Function("scheduleWorklet") { (worklet: Worklet) in
      guard let uiRuntime = (appContext as? any EXAppContextProtocol)?._uiRuntime as? WorkletRuntime else {
        throw Exceptions.RuntimeLost()
      }
      worklet.schedule(on: uiRuntime)
    }

    Function("executeWorkletWithArgs") { (worklet: Worklet) in
      guard let uiRuntime = (appContext as? any EXAppContextProtocol)?._uiRuntime as? WorkletRuntime else {
        throw Exceptions.RuntimeLost()
      }
      worklet.execute(on: uiRuntime, arguments: [2026, "worklet", true])
    }

    Function("scheduleWorkletWithArgs") { (worklet: Worklet) in
      guard let uiRuntime = (appContext as? any EXAppContextProtocol)?._uiRuntime as? WorkletRuntime else {
        throw Exceptions.RuntimeLost()
      }
      worklet.schedule(on: uiRuntime, arguments: [2026, "worklet", true])
    }
  }
}
