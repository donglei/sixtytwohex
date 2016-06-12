module ithox.sitytwohex;
import std.exception;
import std.string;
import std.math;
import std.format;
import ithox.vector;
///
enum string DEFAULT_CHAR_STRING = "AcpINCZb0QKdnX2UERi79VjPHkeuTyYJz4tgmhof8vlS63G5wDrBFWaqOx1MsL";
///
enum HEX_LEN = DEFAULT_CHAR_STRING.length;

///62进制转换
class SityTwoHexEncrypt
{
	static size_t decode(string hex)
	{
		hex = hex.strip;
		if(hex.length == 0)
		{
			throw new Exception("hex string is empty");
		}
		size_t decimal = 0;
		for(auto i = hex.length; i > 0; i--)
		{
			auto _index = DEFAULT_CHAR_STRING.indexOf(hex[i-1]);
			decimal += _index * pow(HEX_LEN, hex.length -i);
		}
		return decimal;
	}

	static string encode(size_t num)
	{
		import std.experimental.allocator.gc_allocator;
		Vector!(char, false, GCAllocator) hex;
		size_t shang = num;
		size_t yu = 0;
		do{
			yu = shang % HEX_LEN;
			shang = shang / HEX_LEN;
			hex.insertBefore(DEFAULT_CHAR_STRING[yu]);
		}while(shang != 0);
		if(hex.length < 6)
		{

			auto l = hex.data(false);
			size_t len = 6 - hex.length;
			char[] data = new char[6];
			data[len..$] = l[];
			data[0..len] = DEFAULT_CHAR_STRING[0];
			return cast(string)data;
		}
		else
		{
			return cast(string)hex.dup;
		}
	}
}


unittest{
	assert(SityTwoHexEncrypt.decode("A") == 0);
	assert(SityTwoHexEncrypt.decode("AAAA") == 0);
	assert(SityTwoHexEncrypt.decode("AAAAAA") == 0);

	assert(SityTwoHexEncrypt.decode("AAAAAc") == 1);
	assert(SityTwoHexEncrypt.decode("c") == 1);
	assert(SityTwoHexEncrypt.decode("L") == 61);


}