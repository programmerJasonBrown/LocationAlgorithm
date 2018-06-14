/*
 * MATLAB Compiler: 6.5 (R2017b)
 * Date: Thu Jun 14 15:58:02 2018
 * Arguments: 
 * "-B""macro_default""-W""java:getLocation,GetLocation""-T""link:lib""-d""I:\\研二\\室内定位\\钱潮论文\\程序\\LS\\getLocation\\for_testing""class{GetLocation:I:\\研二\\室内定位\\钱潮论文\\程序\\LS\\3s使用版\\getX.m}"
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
    private static final String sComponentId = "getLocation_350FE7DD999FB9098D39FA4F12721FC3";
    
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
