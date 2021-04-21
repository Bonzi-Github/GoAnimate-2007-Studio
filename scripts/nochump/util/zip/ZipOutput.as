package nochump.util.zip
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   
   public class ZipOutput
   {
       
      
      private var _def:Deflater;
      
      private var _names:Dictionary;
      
      private var _entries:Array;
      
      private var _crc:CRC32;
      
      private var _comment:String = "";
      
      private var _entry:ZipEntry;
      
      private var _buf:ByteArray;
      
      public function ZipOutput()
      {
         _entries = [];
         _names = new Dictionary();
         _def = new Deflater();
         _crc = new CRC32();
         _buf = new ByteArray();
         super();
         _buf.endian = Endian.LITTLE_ENDIAN;
      }
      
      public function get size() : uint
      {
         return _entries.length;
      }
      
      private function writeEXT(param1:ZipEntry) : void
      {
         _buf.writeUnsignedInt(ZipConstants.EXTSIG);
         _buf.writeUnsignedInt(param1.crc);
         _buf.writeUnsignedInt(param1.compressedSize);
         _buf.writeUnsignedInt(param1.size);
      }
      
      public function finish() : void
      {
         if(_entry != null)
         {
            closeEntry();
         }
         if(_entries.length < 1)
         {
            throw new ZipError("ZIP file must have at least one entry");
         }
         var _loc1_:uint = _buf.position;
         var _loc2_:uint = 0;
         while(_loc2_ < _entries.length)
         {
            writeCEN(_entries[_loc2_]);
            _loc2_++;
         }
         writeEND(_loc1_,_buf.position - _loc1_);
      }
      
      public function closeEntry() : void
      {
         var _loc1_:ZipEntry = _entry;
         if(_loc1_ != null)
         {
            switch(_loc1_.method)
            {
               case ZipConstants.DEFLATED:
                  if((_loc1_.flag & 8) == 0)
                  {
                     if(_loc1_.size != _def.getBytesRead())
                     {
                        throw new ZipError("invalid entry size (expected " + _loc1_.size + " but got " + _def.getBytesRead() + " bytes)");
                     }
                     if(_loc1_.compressedSize != _def.getBytesWritten())
                     {
                        throw new ZipError("invalid entry compressed size (expected " + _loc1_.compressedSize + " but got " + _def.getBytesWritten() + " bytes)");
                     }
                     if(_loc1_.crc != _crc.getValue())
                     {
                        throw new ZipError("invalid entry CRC-32 (expected 0x" + _loc1_.crc + " but got 0x" + _crc.getValue() + ")");
                     }
                  }
                  else
                  {
                     _loc1_.size = _def.getBytesRead();
                     _loc1_.compressedSize = _def.getBytesWritten();
                     _loc1_.crc = _crc.getValue();
                     writeEXT(_loc1_);
                  }
                  _def.reset();
                  break;
               case ZipConstants.STORED:
                  break;
               default:
                  throw new Error("invalid compression method");
            }
            _crc.reset();
            _entry = null;
         }
      }
      
      public function write(param1:ByteArray) : void
      {
         var _loc2_:ByteArray = null;
         if(_entry == null)
         {
            throw new ZipError("no current ZIP entry");
         }
         switch(_entry.method)
         {
            case ZipConstants.DEFLATED:
               _loc2_ = new ByteArray();
               _def.setInput(param1);
               _def.deflate(_loc2_);
               _buf.writeBytes(_loc2_);
               break;
            case ZipConstants.STORED:
               _buf.writeBytes(param1);
               break;
            default:
               throw new Error("invalid compression method");
         }
         _crc.update(param1);
      }
      
      private function writeLOC(param1:ZipEntry) : void
      {
         _buf.writeUnsignedInt(ZipConstants.LOCSIG);
         _buf.writeShort(param1.version);
         _buf.writeShort(param1.flag);
         _buf.writeShort(param1.method);
         _buf.writeUnsignedInt(param1.dostime);
         if((param1.flag & 8) == 8)
         {
            _buf.writeUnsignedInt(0);
            _buf.writeUnsignedInt(0);
            _buf.writeUnsignedInt(0);
         }
         else
         {
            _buf.writeUnsignedInt(param1.crc);
            _buf.writeUnsignedInt(param1.compressedSize);
            _buf.writeUnsignedInt(param1.size);
         }
         _buf.writeShort(param1.name.length);
         _buf.writeShort(param1.extra != null?int(param1.extra.length):0);
         _buf.writeUTFBytes(param1.name);
         if(param1.extra != null)
         {
            _buf.writeBytes(param1.extra);
         }
      }
      
      private function writeCEN(param1:ZipEntry) : void
      {
         _buf.writeUnsignedInt(ZipConstants.CENSIG);
         _buf.writeShort(param1.version);
         _buf.writeShort(param1.version);
         _buf.writeShort(param1.flag);
         _buf.writeShort(param1.method);
         _buf.writeUnsignedInt(param1.dostime);
         _buf.writeUnsignedInt(param1.crc);
         _buf.writeUnsignedInt(param1.compressedSize);
         _buf.writeUnsignedInt(param1.size);
         _buf.writeShort(param1.name.length);
         _buf.writeShort(param1.extra != null?int(param1.extra.length):0);
         _buf.writeShort(param1.comment != null?int(param1.comment.length):0);
         _buf.writeShort(0);
         _buf.writeShort(0);
         _buf.writeUnsignedInt(0);
         _buf.writeUnsignedInt(param1.offset);
         _buf.writeUTFBytes(param1.name);
         if(param1.extra != null)
         {
            _buf.writeBytes(param1.extra);
         }
         if(param1.comment != null)
         {
            _buf.writeUTFBytes(param1.comment);
         }
      }
      
      public function putNextEntry(param1:ZipEntry) : void
      {
         if(_entry != null)
         {
            closeEntry();
         }
         if(param1.dostime == 0)
         {
            param1.time = new Date().time;
         }
         if(param1.method == -1)
         {
            param1.method = ZipConstants.DEFLATED;
         }
         switch(param1.method)
         {
            case ZipConstants.DEFLATED:
               if(param1.size == -1 || param1.compressedSize == -1 || param1.crc == 0)
               {
                  param1.flag = 8;
               }
               else
               {
                  if(!(param1.size != -1 && param1.compressedSize != -1 && param1.crc != 0))
                  {
                     throw new ZipError("DEFLATED entry missing size, compressed size, or crc-32");
                  }
                  param1.flag = 0;
               }
               param1.version = 20;
               break;
            case ZipConstants.STORED:
               if(param1.size == -1)
               {
                  param1.size = param1.compressedSize;
               }
               else if(param1.compressedSize == -1)
               {
                  param1.compressedSize = param1.size;
               }
               else if(param1.size != param1.compressedSize)
               {
                  throw new ZipError("STORED entry where compressed != uncompressed size");
               }
               if(param1.size == -1 || param1.crc == 0)
               {
                  throw new ZipError("STORED entry missing size, compressed size, or crc-32");
               }
               param1.version = 10;
               param1.flag = 0;
               break;
            default:
               throw new ZipError("unsupported compression method");
         }
         param1.offset = _buf.position;
         if(_names[param1.name] != null)
         {
            throw new ZipError("duplicate entry: " + param1.name);
         }
         _names[param1.name] = param1;
         writeLOC(param1);
         _entries.push(param1);
         _entry = param1;
      }
      
      public function get byteArray() : ByteArray
      {
         _buf.position = 0;
         return _buf;
      }
      
      private function writeEND(param1:uint, param2:uint) : void
      {
         _buf.writeUnsignedInt(ZipConstants.ENDSIG);
         _buf.writeShort(0);
         _buf.writeShort(0);
         _buf.writeShort(_entries.length);
         _buf.writeShort(_entries.length);
         _buf.writeUnsignedInt(param2);
         _buf.writeUnsignedInt(param1);
         _buf.writeUTF(_comment);
      }
      
      public function set comment(param1:String) : void
      {
         _comment = param1;
      }
   }
}
