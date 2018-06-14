/*
 * MATLAB Compiler: 6.5 (R2017b)
 * Date: Thu Jun 14 15:06:57 2018
 * Arguments: 
 * "-B""macro_default""-W""java:getLocation,GetLocation""-T""link:lib""-d""I:\\研二\\室内定位\\钱潮论文\\程序\\LS\\getLocation\\for_testing""class{GetLocation:I:\\研二\\室内定位\\钱潮论文\\程序\\LS\\getX.m}"
 */

package getLocation;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class GetLocationMCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "getLocation_D4D9B502934E49B296532B6C060A9B62";
    
    /** Component name */
    private static final String sComponentName = "getLocation";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(GetLocationMCRFactory.class)
        );
    
    
    private GetLocationMCRFactory()
    {
        // Never called.
    }
    
    public static MWMCR newInstance(MWComponentOptions componentOptions) throws MWException
    {
        if (null == componentOptions.getCtfSource()) {
            componentOptions = new MWComponentOptions(componentOptions);
            componentOptions.setCtfSource(sDefaultComponentOptions.getCtfSource());
        }
        return MWMCR.newInstance(
            componentOptions, 
            GetLocationMCRFactory.class, 
            sComponentName, 
            sComponentId,
            new int[]{9,3,0}
        );
    }
    
    public static MWMCR newInstance() throws MWException
    {
        return newInstance(sDefaultComponentOptions);
    }
}
