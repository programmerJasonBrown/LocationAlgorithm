/*
 * MATLAB Compiler: 6.5 (R2017b)
 * Date: Thu Jun 14 15:58:02 2018
 * Arguments: 
 * "-B""macro_default""-W""java:getLocation,GetLocation""-T""link:lib""-d""I:\\研二\\室内定位\\钱潮论文\\程序\\LS\\getLocation\\for_testing""class{GetLocation:I:\\研二\\室内定位\\钱潮论文\\程序\\LS\\3s使用版\\getX.m}"
 */

package getLocation;

import com.mathworks.toolbox.javabuilder.pooling.Poolable;
import java.util.List;
import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * The <code>GetLocationRemote</code> class provides a Java RMI-compliant interface to 
 * MATLAB functions. The interface is compiled from the following files:
 * <pre>
 *  I:\\研二\\室内定位\\钱潮论文\\程序\\LS\\3s使用版\\getX.m
 * </pre>
 * The {@link #dispose} method <b>must</b> be called on a <code>GetLocationRemote</code> 
 * instance when it is no longer needed to ensure that native resources allocated by this 
 * class are properly freed, and the server-side proxy is unexported.  (Failure to call 
 * dispose may result in server-side threads not being properly shut down, which often 
 * appears as a hang.)  
 *
 * This interface is designed to be used together with 
 * <code>com.mathworks.toolbox.javabuilder.remoting.RemoteProxy</code> to automatically 
 * generate RMI server proxy objects for instances of getLocation.GetLocation.
 */
public interface GetLocationRemote extends Poolable
{
    /**
     * Provides the standard interface for calling the <code>getX</code> MATLAB function 
     * with 1 input argument.  
     *
     * Input arguments to standard interface methods may be passed as sub-classes of 
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of any 
     * supported Java type (i.e. scalars and multidimensional arrays of any numeric, 
     * boolean, or character type, or String). Arguments passed as Java types are 
     * converted to MATLAB arrays according to default conversion rules.
     *
     * All inputs to this method must implement either Serializable (pass-by-value) or 
     * Remote (pass-by-reference) as per the RMI specification.
     *
     * No usage documentation is available for this function.  (To fix this, the function 
     * author should insert a help comment at the beginning of their MATLAB code.  See 
     * the MATLAB documentation for more details.)
     *
     * @param nargout Number of outputs to return.
     * @param rhs The inputs to the MATLAB function.
     *
     * @return Array of length nargout containing the function outputs. Outputs are 
     * returned as sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>. 
     * Each output array should be freed by calling its <code>dispose()</code> method.
     *
     * @throws java.rmi.RemoteException An error has occurred during the function call or 
     * in communication with the server.
     */
    public Object[] getX(int nargout, Object... rhs) throws RemoteException;
  
    /** 
     * Frees native resources associated with the remote server object 
     * @throws java.rmi.RemoteException An error has occurred during the function call or in communication with the server.
     */
    void dispose() throws RemoteException;
}
