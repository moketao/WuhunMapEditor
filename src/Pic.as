package
{
	import flash.display.Bitmap;

	public class Pic extends DragSprite
	{
		public function Pic(bmp:Bitmap)
		{
			addChild(bmp);
		}
	}
}