import Aeneas.Std.Core.Fmt
import Aeneas.Std.String

namespace Aeneas.Std

/-- The (deprecated) `description` method of `core::error::Error` has a default
    body in Rust which simply returns a fixed string literal:
    ```
    fn description(&self) -> &str { "description() is deprecated; use Display" }
    ```
    That body lives in (opaque) `core`, so we model it here rather than let
    Aeneas emit an unfoldable axiom for it — otherwise `impl_def` cannot
    discharge the self-reference in implementations that keep the default. -/
@[rust_trait "core::error::Error"
  (parentClauses := ["fmtDebugInst", "fmtDisplayInst"])
  (defaultMethods := ["description"])]
structure core.error.Error (Self : Type) where
  fmtDebugInst : core.fmt.Debug Self
  fmtDisplayInst : core.fmt.Display Self
  description : Self → Result Str :=
    fun _ => .ok (toStr "description() is deprecated; use Display")

@[trait_default]
def core.error.Error.description.default {Self : Type}
  (_ErrorInst : core.error.Error Self) (_self : Self) : Result Str :=
  .ok (toStr "description() is deprecated; use Display")

end Aeneas.Std
