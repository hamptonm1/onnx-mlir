// SPDX-License-Identifier: Apache-2.0

//===-------------------- KrnlGlobalOpInterface.hpp -----------------------===//
//===---------------- KrnlGlobal Op Interface Definition ------------------===//
//
// Copyright 2024 The IBM Research Authors.
//
// =============================================================================
//
// This file contains the TableGen definition of the Constant Op
// Interface Definition.
//
//===----------------------------------------------------------------------===//

#ifdef KRNLGLOBAL_OP_INTERFACE
#else
#define KRNLGLOBAL_OP_INTERFACE

include "mlir/IR/OpBase.td"

def KrnlGlobalOpInterface : OpInterface<"KrnlGlobalOpInterface"> {
  let description = [{
    A KrnlGlobalOp-like operation is one that holds global constant value. It has
    `name` attribute, `shape` attribute, `offset` attribute, and `alighnment`
    attribute. Its content is stored in the `value` attribute, which can be
    converted when retrieving.
  }];

  let methods = [
      InterfaceMethod<"Get the buffer for the constant value from value attribute. "
                      "If conversions are required to get the buffer. It should be "
		      "done in this method. The constant value is stored in newly  "
		      "allocated buffer. The buffer needs to be freed afte use by  "
		      "using `freeBuffer()`.",
          "::mlir::ArrayRef<char>", "getBuffer", (ins )
      >,
      InterfaceMethod<"Get the size of the buffer. ",
          "uint64_t", "getBufferSize", (ins )
      >,
      InterfaceMethod<"Free the buffer for the constant value retrieved from value "
                      "attribute.",
          "void", "freeBuffer", (ins "::mlir::ArrayRef<char>": $buffer)
      >,
      InterfaceMethod<"Update the `value` attribute by converting existing `value` "
                       "attribute. Assume to use getBuffer(), setValueAttr(), and  "
		       "freeBuffer() in this function.",
          "void", "updateValueAttr", (ins )
      >,
      InterfaceMethod<"Get the value from the attribute.",
          "std::optional<Attribute>", "getValue", (ins )
      >,
      InterfaceMethod<"Get the `value` attribute.",
          "Attribute", "getValueAttr", (ins )
      >,
      InterfaceMethod<"Remove value attribute.",
          "Attribute", "removeValueAttr", (ins )
      >,
      InterfaceMethod<"Get the `alignment` attribute.",
          "std::optional<uint64_t>", "getAlignment", (ins )
      >,
      InterfaceMethod<"Get the attribute for the alignment.",
          "IntegerAttr", "getAlignmentAttr", (ins )
      >,
      InterfaceMethod<"Get the `shape` attribute.",
          "::mlir::Attribute", "getShape", (ins )
      >,
      InterfaceMethod<"Get the `name` attribute.",
          "::mlir::StringRef", "getName", (ins )
      >,
      InterfaceMethod<"Set the offset to the attribute.",
          "void", "setOffsetAttr", (ins "::mlir::IntegerAttr": $attr)
      >,
      InterfaceMethod<"Get the `offset` attribute.",
          "std::optional<uint64_t>", "getOffset", (ins )
      >
  ];

  let extraClassDeclaration = [{
    /// Return the single result of this op.
    ::mlir::Value getResult() {
      return getOperation()->getResult(0);
    }
  }];

  let cppNamespace = "::mlir";
}

#endif // KRNLGLOBAL_OP_INTERFACE
