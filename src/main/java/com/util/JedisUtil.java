package com.util;
import org.springframework.stereotype.Component;

import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

@Component
public class JedisUtil {
	// Singleton單例模式
	private static JedisPool pool = null;

	private JedisUtil() {
	}

	/**
     * 獲取 Jedis 資源
     * 
     */
	public static JedisPool getJedisPool() {
		// double lock
		if (pool == null) {
			synchronized(JedisUtil.class) {
				if (pool == null) {
					JedisPoolConfig config = new JedisPoolConfig();
					//連接耗盡時是否阻塞, false報異常,ture阻塞直到超時, 默認true
		            config.setBlockWhenExhausted(true);
		            //設置的逐出策略類名, 默認DefaultEvictionPolicy(當連接超過最大空閒時間,或連接數超過最大空閒連接數)
		            config.setEvictionPolicyClassName("org.apache.commons.pool2.impl.DefaultEvictionPolicy");
		            //是否啓用pool的jmx管理功能, 默認true
		            config.setJmxEnabled(true);
		            //MBean ObjectName = new ObjectName("org.apache.commons.pool2:type=GenericObjectPool,name=" + "pool" + i); 默認爲"pool", JMX不熟,具體不知道是幹啥的...默認就好.
		            config.setJmxNamePrefix("pool");
		            //是否啓用後進先出, 默認true
		            config.setLifo(true);
		            //最大空閒連接數, 默認8個
		            config.setMaxIdle(8);
		            //最大連接數, 默認8個
		            config.setMaxTotal(8);
		            //獲取連接時的最大等待毫秒數(如果設置爲阻塞時BlockWhenExhausted),如果超時就拋異常, 小於零:阻塞不確定的時間,  默認-1
		            config.setMaxWaitMillis(-1);
		            //逐出連接的最小空閒時間 默認1800000毫秒(30分鐘)
		            config.setMinEvictableIdleTimeMillis(1800000);
		            //最小空閒連接數, 默認0
		            config.setMinIdle(0);
		            //每次逐出檢查時 逐出的最大數目 如果爲負數就是 : 1/abs(n), 默認3
		            config.setNumTestsPerEvictionRun(3);
		            //對象空閒多久後逐出, 當空閒時間>該值 且 空閒連接>最大空閒數 時直接逐出,不再根據MinEvictableIdleTimeMillis判斷  (默認逐出策略)
		            config.setSoftMinEvictableIdleTimeMillis(1800000);
		            //在獲取連接的時候檢查有效性, 默認false
		            config.setTestOnBorrow(false);
		            //在空閒時檢查有效性, 默認false
		            config.setTestWhileIdle(false);
		            //逐出掃描的時間間隔(毫秒) 如果爲負數,則不運行逐出線程, 默認-1
		            config.setTimeBetweenEvictionRunsMillis(-1);

					pool = new JedisPool(config, "localhost", 6379);
				}
			}
		}
		return pool;
	}

	/**
     * 釋放Jedis資源
     */
	public static void shutdownJedisPool() {
		if (pool != null)
			pool.destroy();
	}

}
