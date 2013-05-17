package com.firestartermedia.lib.as3.display.shape
{
    import flash.display.GradientType;
    import flash.display.Shape;
    import flash.geom.Matrix;
    
    public class Rectangle extends Shape
    {
        private var mat:Matrix;
        
        public function Rectangle(width:Number=1, 
                                  height:Number=1, 
                                  bgColour:*=0xFF6600, 
                                  borderColour:uint=0x000099, 
                                  borderThickness:Number=1,
                                  borderAlpha:Number=1)
        {
            super();
            
            draw( width, height, bgColour, borderColour, borderThickness, borderAlpha );
        }
        
        public function draw(width:Number, height:Number, bgColour:*, borderColour:uint, borderThickness:Number, borderAlpha:Number):void
        {
            graphics.clear();
            
            if (bgColour is Array)
            {
                if (!mat)
                {
                    mat = new Matrix();
                    
                    mat.createGradientBox(height, width, Math.PI * .5);
                }
                
                graphics.beginGradientFill(GradientType.LINEAR, bgColour, [1, 1], [0, 255], mat);
            }
            else
            {
                graphics.beginFill( bgColour );
            }
            
            if (borderThickness)
            {
                graphics.lineStyle( borderThickness, borderColour, borderAlpha );
            }
            
            graphics.moveTo(0, 0);
            graphics.lineTo(width, 0);
            graphics.lineTo(width, height);
            graphics.lineTo(0, height);
            graphics.lineTo(0, 0);
            graphics.endFill();
            
            cacheAsBitmap = true;
        }
    }
}