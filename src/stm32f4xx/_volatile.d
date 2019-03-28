module stm32f4xx._volatile;

version(LDC)
{
  import ldc.llvmasm;
  
      pragma(LDC_intrinsic, "ldc.bitop.vld")
        ubyte volatileLoad1(ubyte* ptr);
    pragma(LDC_intrinsic, "ldc.bitop.vld")
        ushort volatileLoad2(ushort* ptr);  /// ditto
    pragma(LDC_intrinsic, "ldc.bitop.vld")
        uint volatileLoad4(uint* ptr);      /// ditto
    pragma(LDC_intrinsic, "ldc.bitop.vld")
        ulong volatileLoad8(ulong* ptr);    /// ditto

    pragma(LDC_intrinsic, "ldc.bitop.vst")
        void volatileStore1(ubyte* ptr, ubyte value);   /// ditto
    pragma(LDC_intrinsic, "ldc.bitop.vst")
        void volatileStore2(ushort* ptr, ushort value); /// ditto
    pragma(LDC_intrinsic, "ldc.bitop.vst")
        void volatileStore4(uint* ptr, uint value);     /// ditto
    pragma(LDC_intrinsic, "ldc.bitop.vst")
        void volatileStore8(ulong* ptr, ulong value);   /// ditto
}

 
//pragma(LDC_no_typeinfo)
//{
struct Volatile(T)
{
private:
    T _store;

public:
    @disable this(this);
	
	//alias load this;
		
	pragma(inline, true) T opCast(string type)() const
	{
		static if(_store.sizeof == 4)
			return volatileLoad4(cast(uint*)&_store);
		else if(_store.sizeof == 2)
			return volatileLoad2(cast(ushort*)&_store);
		else if(_store.sizeof == 1)
			return volatileLoad1(cast(ubyte*)&_store);
		else if(_store.sizeof == 8)
			return volatileLoad8(cast(ulong*)&_store);
	}
	
    /**
     * Performs 1 load followed by 1 store
     */
    pragma(inline, true) void opOpAssign(string op)(in T rhs)
    {
        //T val = volatileLoad(&_store);
		static if(_store.sizeof == 4)
			T val = volatileLoad4(cast(uint*)&_store);
		else if(_store.sizeof == 2)
			T val = volatileLoad2(cast(ushort*)&_store);
		else if(_store.sizeof == 1)
			T val = volatileLoad1(cast(ubyte*)&_store);
		else if(_store.sizeof == 8)
			T val = volatileLoad8(cast(ulong*)&_store);
		else
			static assert(0, T.sizeof);
		
        mixin("val" ~ op ~ "= rhs;");
		
        //volatileStore(&_store, val);
		
		static if(_store.sizeof == 4)
			volatileStore4(cast(uint*)&_store, val);
		else if(_store.sizeof == 2)
			volatileStore2(cast(ushort*)&_store, val);
		else if(_store.sizeof == 1)
			volatileStore1(cast(ubyte*)&_store, val);
		else if(_store.sizeof == 8)
			volatileStore8(cast(ulong*)&_store, val);
		else
			static assert(0);
    }

    /**
     * Performs 1 store
     */
    pragma(inline, true) void opAssign()(const T rhs)
    {
		static if(T.sizeof == 4)
			volatileStore4(cast(uint*)&_store, rhs);
		else if(T.sizeof == 2)
			volatileStore2(cast(ushort*)&_store, rhs);
		else if(T.sizeof == 1)
			volatileStore1(cast(ubyte*)&_store, rhs);
		else if(T.sizeof == 8)
			volatileStore8(cast(ulong*)&_store, rhs);
		else
			static assert(0, T.sizeof);
    }

    /**
     * Performs 1 load
     */
    pragma(inline, true) T load()() const
    {
		static if(_store.sizeof == 4)
			return volatileLoad4(cast(uint*)&_store);
		else if(_store.sizeof == 2)
			return volatileLoad2(cast(ushort*)&_store);
		else if(_store.sizeof == 1)
			return volatileLoad1(cast(ubyte*)&_store);
		else if(_store.sizeof == 8)
			return volatileLoad8(cast(ulong*)&_store);
		else
			static assert(0);
    }

    /**
     * Performs 1 load
     */
    pragma(inline, true) bool opEquals()(const T rhs) const
    {
		static if(_store.sizeof == 4)
			return volatileLoad4(cast(uint*)&_store) == rhs;
		else if(_store.sizeof == 2)
			return volatileLoad2(cast(ushort*)&_store) == rhs;
		else if(_store.sizeof == 1)
			return volatileLoad1(cast(ubyte*)&_store) == rhs;
		else if(_store.sizeof == 8)
			return volatileLoad8(cast(ulong*)&_store) == rhs;
		else
			static assert(0);
		}

    /**
     * Performs 1 load
     */
    pragma(inline, true)int opCmp()(const T rhs) const
    {
		static if(_store.sizeof == 4)
			T val = volatileLoad4(cast(uint*)&_store);
		else if(_store.sizeof == 2)
			T val = volatileLoad2(cast(ushort*)&_store);
		else if(_store.sizeof == 1)
			T val = volatileLoad1(cast(ubyte*)&_store);
		else if(_store.sizeof == 8)
			T val = volatileLoad8(cast(ubyte*)&_store);
		else
			static assert(0);
			
        if(val == rhs)
            return 0;
        else if(val < rhs)
            return -1;
        else
            return 1;
    }
}
//}
 