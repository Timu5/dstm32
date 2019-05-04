module stm32f4xx._volatile;

version (LDC)
{
	import ldc.llvmasm;

	pragma(LDC_intrinsic, "ldc.bitop.vld") ubyte volatileLoad(ubyte* ptr);
	pragma(LDC_intrinsic, "ldc.bitop.vld") ushort volatileLoad(ushort* ptr); /// ditto
	pragma(LDC_intrinsic, "ldc.bitop.vld") uint volatileLoad(uint* ptr); /// ditto
	pragma(LDC_intrinsic, "ldc.bitop.vld") ulong volatileLoad(ulong* ptr); /// ditto

	pragma(LDC_intrinsic, "ldc.bitop.vst") void volatileStore(ubyte* ptr, ubyte value); /// ditto
	pragma(LDC_intrinsic, "ldc.bitop.vst") void volatileStore(ushort* ptr, ushort value); /// ditto
	pragma(LDC_intrinsic, "ldc.bitop.vst") void volatileStore(uint* ptr, uint value); /// ditto
	pragma(LDC_intrinsic, "ldc.bitop.vst") void volatileStore(ulong* ptr, ulong value); /// ditto
}

struct Volatile(T)
{
private:
	T _store;

public:
	@disable this(this);

	/**
     * Performs 1 load followed by 1 store
     */
	pragma(inline, true) void opOpAssign(string op)(in T rhs)
	{
		T val = volatileLoad(cast(T*)&_store);

		mixin("val" ~ op ~ "= rhs;");

		volatileStore(cast(T*)&_store, val);
	}

	/**
     * Performs 1 store
     */
	pragma(inline, true) void opAssign()(const T rhs)
	{
		volatileStore(cast(T*)&_store, rhs);
	}

	/**
     * Performs 1 load
     */
	pragma(inline, true) T load()() const
	{
		return volatileLoad(cast(T*)&_store);
	}

	/**
     * Performs 1 load
     */
	pragma(inline, true) bool opEquals()(const T rhs) const
	{
		return volatileLoad(cast(T*)&_store) == rhs;
	}

	/**
     * Performs 1 load
     */
	pragma(inline, true) int opCmp()(const T rhs) const
	{
		T val = volatileLoad(cast(T*)&_store);

		if (val == rhs)
			return 0;
		else if (val < rhs)
			return -1;
		else
			return 1;
	}
}
